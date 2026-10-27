using System.Diagnostics;
using System.Text.Json.Nodes;

internal sealed class DependencyUpdater(
	Func<string, IReadOnlyList<string>, bool, Task<string>> runCommand,
	Func<string, string, Task<string>> latestNuGetVersion,
	TextWriter output,
	TextWriter error)
{
	private const string Usage = "Usage: dotnet run --file scripts/update-dependencies.cs -- [--system <system>] [dependency...]";

	private static async Task<int> Main(string[] args)
	{
		try
		{
			var directory = new DirectoryInfo(Directory.GetCurrentDirectory());
			while (directory is not null && !File.Exists(Path.Combine(directory.FullName, "pkgs", "dependencies.nix")))
			{
				directory = directory.Parent;
			}
			var root = directory?.FullName ?? throw new Exception("Run from within the my-nixpkgs repository");
			using var client = new HttpClient { Timeout = TimeSpan.FromSeconds(30) };
			var updater = new DependencyUpdater(
				(file, arguments, capture) => RunProcess(root, file, arguments, capture),
				(packageId, prefix) => GetLatestNuGetVersion(client, packageId, prefix),
				Console.Out,
				Console.Error);
			return await updater.Run(args);
		}
		catch (Exception exception)
		{
			Console.Error.WriteLine(exception.Message);
			return 1;
		}
	}

	internal async Task<int> Run(string[] args)
	{
		string? system = null;
		var filters = new List<string>();
		for (var i = 0; i < args.Length; i++)
		{
			var argument = args[i];
			if (argument is "--help" or "-h")
			{
				output.WriteLine(Usage);
				return 0;
			}
			if (argument == "--system" && i + 1 < args.Length && !args[i + 1].StartsWith('-'))
			{
				system = args[++i];
			}
			else if (argument.StartsWith("--system=", StringComparison.Ordinal) && argument.Length > "--system=".Length)
			{
				system = argument["--system=".Length..];
			}
			else if (argument.StartsWith('-'))
			{
				error.WriteLine($"Invalid option: {argument}{Environment.NewLine}{Usage}");
				return 2;
			}
			else
			{
				filters.Add(argument);
			}
		}

		var json = await runCommand("nix", ["eval", "--json", "--file", "pkgs/dependencies.nix"], true);
		var dependencies = JsonNode.Parse(json) as JsonObject ?? throw new Exception("Expected a dependency metadata object");
		var selected = filters.Count == 0
			? dependencies.Select(entry => entry.Key).Order(StringComparer.Ordinal).ToArray()
			: filters.Distinct(StringComparer.Ordinal).ToArray();
		var unknown = selected.Where(name => !dependencies.ContainsKey(name)).ToArray();
		if (unknown.Length > 0)
		{
			error.WriteLine($"Unknown dependencies: {string.Join(", ", unknown)}");
			return 2;
		}
		system ??= (await runCommand("nix", ["eval", "--impure", "--raw", "--expr", "builtins.currentSystem"], true)).Trim();
		var failed = new List<string>();
		foreach (var name in selected)
		{
			try
			{
				await UpdateEntry(name, dependencies[name]!.AsObject(), system);
			}
			catch (Exception exception)
			{
				error.WriteLine($"failed: {name}: {exception.Message}");
				failed.Add(name);
			}
		}
		if (failed.Count == 0)
		{
			return 0;
		}
		error.WriteLine($"Failed updates: {string.Join(", ", failed)}");
		return 1;
	}

	private async Task UpdateEntry(string name, JsonObject entry, string system)
	{
		var policy = entry["update"]?.AsObject() ?? throw new Exception($"Missing update policy for {name}");
		var strategy = policy["strategy"]?.GetValue<string>();
		if (strategy == "manual")
		{
			output.WriteLine($"skipped (manual): {name}");
			return;
		}
		output.WriteLine($"updating: {name}");
		switch (strategy)
		{
			case "nuget-release":
				var version = await latestNuGetVersion(
					policy["packageId"]?.GetValue<string>() ?? name,
					policy["version"]?["prefix"]?.GetValue<string>() ?? "");
				var platforms = entry["platformPackages"] is JsonObject packages && packages.Count > 0
					? packages.Select(package => (string?)package.Key).ToArray()
					: [null];
				// Set the shared version once, then refresh every hash even when the version is current.
				await NixUpdate(name, system, platforms[0], $"--version={version}", "--no-src", "--src-only");
				foreach (var platform in platforms)
				{
					await NixUpdate(name, system, platform, "--version=skip", "--src-only");
				}
				break;
			case "github-branch":
				await NixUpdate(name, system, null, $"--version=branch={policy["branch"]?.GetValue<string>() ?? "main"}");
				break;
			case "github-release":
			case "pypi-release":
				await NixUpdate(name, system, null);
				break;
			default:
				throw new Exception($"Unsupported update strategy '{strategy}' for {name}");
		}
	}

	private async Task NixUpdate(string name, string system, string? platform, params string[] options)
	{
		var target = $"legacyPackages.{system}.updateTargets.{name}";
		if (platform is not null)
		{
			target += $".{platform}";
		}
		await runCommand("nix-update", [target, "--flake", "--system", system, "--override-filename", $"pkgs/{name}/sources.nix", .. options], false);
	}

	internal static async Task<string> GetLatestNuGetVersion(HttpClient client, string packageId, string prefix)
	{
		var url = $"https://api.nuget.org/v3-flatcontainer/{Uri.EscapeDataString(packageId.ToLowerInvariant())}/index.json";
		var metadata = JsonNode.Parse(await client.GetStringAsync(url));
		var versions = metadata?["versions"]?.AsArray() ?? throw new Exception($"Missing NuGet versions for {packageId}");
		return versions.Select(version => version!.GetValue<string>())
			.LastOrDefault(version => !version.Contains('-') && version.StartsWith(prefix, StringComparison.Ordinal))
			?? throw new Exception($"No stable NuGet version for {packageId} with prefix '{prefix}'");
	}

	private static async Task<string> RunProcess(string root, string file, IReadOnlyList<string> arguments, bool capture)
	{
		var startInfo = new ProcessStartInfo(file)
		{
			WorkingDirectory = root,
			UseShellExecute = false,
			RedirectStandardOutput = capture,
		};
		foreach (var argument in arguments)
		{
			startInfo.ArgumentList.Add(argument);
		}
		using var process = Process.Start(startInfo) ?? throw new Exception($"Failed to start {file}");
		var stdout = capture ? process.StandardOutput.ReadToEndAsync() : Task.FromResult("");
		await process.WaitForExitAsync();
		var result = await stdout;
		if (process.ExitCode != 0)
		{
			throw new Exception($"Command failed ({process.ExitCode}): {file} {string.Join(" ", arguments)}");
		}
		return result;
	}
}
