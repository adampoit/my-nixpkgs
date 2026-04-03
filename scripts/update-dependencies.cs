#!/usr/bin/env dotnet

using System.Diagnostics;
using System.Net.Http;
using System.Runtime.InteropServices;
using System.Text;
using System.Text.Json;
using System.Text.Json.Nodes;
using System.Text.RegularExpressions;

const string FakeHash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
const string NuGetServiceIndexUrl = "https://api.nuget.org/v3/index.json";
const string NpmRegistryUrl = "https://registry.npmjs.org";

var currentDirectory = Directory.GetCurrentDirectory();
var repoRoot = File.Exists(Path.Combine(currentDirectory, "pkgs", "dependencies.nix"))
	? currentDirectory
	: Path.GetFullPath(Path.Combine(currentDirectory, ".."));
var depsFile = Path.Combine(repoRoot, "pkgs", "dependencies.nix");
var packageRoot = GetPackageRoot();
var filters = args.ToHashSet(StringComparer.Ordinal);

var data = LoadDependencies(depsFile, repoRoot);
var entries = GetPackageEntries(data).ToList();
var entryPaths = entries.Select(x => x.Path).ToHashSet(StringComparer.Ordinal);
var missing = filters.Where(x => !entryPaths.Contains(x)).OrderBy(x => x).ToList();

if (missing.Count > 0)
{
	throw new Exception($"Unknown dependency path(s): {string.Join(", ", missing)}");
}

var modified = false;

foreach (var entry in entries)
{
	if (filters.Count > 0 && !filters.Contains(entry.Path))
	{
		continue;
	}

	LogStep("checking", entry.Path);
	var entryChanged = ApplyUpdateStrategy(entry, repoRoot);
	string? prefetchedSourcePath = null;
	if (HasGitHubSource(entry.Source))
	{
		LogStep("prefetching source hash", entry.Path);
		var source = entry.Source!;
		var prefetchedSource = PrefetchSource(source, repoRoot);
		prefetchedSourcePath = prefetchedSource.StorePath;
		var newSourceHash = prefetchedSource.Hash;
		var currentSourceHash = source["hash"]?.GetValue<string>() ?? throw new Exception($"Missing source.hash for {entry.Path}");
		if (!StringComparer.Ordinal.Equals(newSourceHash, currentSourceHash))
		{
			source["hash"] = newSourceHash;
			entryChanged = true;
		}
	}

	if (entryChanged && entry.HashFields.Count > 0)
	{
		WriteDependencies(depsFile, data);
		foreach (var field in entry.HashFields)
		{
			LogStep($"resolving {field}", entry.Path);
			var resolvedHash = ResolveHashField(repoRoot, packageRoot, entry, field, depsFile, data, prefetchedSourcePath);
			var currentHash = entry.Node[field]?.GetValue<string>();
			if (!StringComparer.Ordinal.Equals(resolvedHash, currentHash))
			{
				entry.Node[field] = resolvedHash;
				entryChanged = true;
			}
		}
	}

	if (entryChanged)
	{
		modified = true;
	}

	Console.WriteLine($"{(entryChanged ? "updated" : "ok")}: {entry.Path}");
}

if (modified)
{
	WriteDependencies(depsFile, data);
}

static JsonObject LoadDependencies(string depsFile, string workingDirectory)
{
	var output = RunAndCapture("nix", ["eval", "--json", "--file", depsFile], workingDirectory);
	return JsonNode.Parse(output) as JsonObject ?? throw new Exception("Expected dependencies.nix to evaluate to a JSON object");
}

static IEnumerable<DependencyEntry> GetPackageEntries(JsonObject data)
{
	foreach (var kvp in data)
	{
		if (kvp.Value is not JsonObject node)
		{
			throw new Exception($"Expected dependency '{kvp.Key}' to be a JSON object");
		}

		if (node["update"] is not JsonObject update || update["strategy"] is not JsonValue)
		{
			throw new Exception($"Dependency '{kvp.Key}' is missing required update.strategy metadata");
		}

		yield return new DependencyEntry(kvp.Key, node, node["source"] as JsonObject, update);
	}
}

static bool HasGitHubSource(JsonObject? source) =>
	source is not null &&
	source["owner"] is JsonValue &&
	source["repo"] is JsonValue &&
	source["rev"] is JsonValue &&
	source["hash"] is JsonValue;

static bool ApplyUpdateStrategy(DependencyEntry entry, string workingDirectory)
{
	var strategy = entry.Update["strategy"]?.GetValue<string>() ?? throw new Exception($"Missing update.strategy for {entry.Path}");
	LogStep($"strategy {strategy}", entry.Path);
	return strategy switch
	{
		"manual" => false,
		"github-branch" => ApplyGitHubBranchUpdate(entry, workingDirectory),
		"github-release" => ApplyGitHubReleaseUpdate(entry, workingDirectory),
		"nuget-release" => ApplyNuGetReleaseUpdate(entry),
		"npm-registry-release" => ApplyNpmRegistryReleaseUpdate(entry, workingDirectory),
		_ => throw new Exception($"Unsupported update strategy '{strategy}' for {entry.Path}"),
	};
}

static bool ApplyGitHubBranchUpdate(DependencyEntry entry, string workingDirectory)
{
	if (!HasGitHubSource(entry.Source))
	{
		throw new Exception($"github-branch requires source.owner, source.repo, source.rev, and source.hash for {entry.Path}");
	}

	LogStep("checking GitHub branch", entry.Path);
	var source = entry.Source!;
	var owner = source["owner"]?.GetValue<string>() ?? throw new Exception($"Missing source.owner for {entry.Path}");
	var repo = source["repo"]?.GetValue<string>() ?? throw new Exception($"Missing source.repo for {entry.Path}");
	var branch = entry.Update["branch"]?.GetValue<string>() ?? "main";
	var commit = GetGitHubBranchHead(owner, repo, branch, workingDirectory);
	var currentRev = source["rev"]?.GetValue<string>() ?? throw new Exception($"Missing source.rev for {entry.Path}");
	if (StringComparer.Ordinal.Equals(currentRev, commit))
	{
		return false;
	}

	source["rev"] = commit;
	return true;
}

static bool ApplyNuGetReleaseUpdate(DependencyEntry entry)
{
	LogStep("checking NuGet release", entry.Path);
	var currentVersion = entry.Node["version"]?.GetValue<string>() ?? throw new Exception($"Missing version for {entry.Path}");
	var nextVersion = GetLatestNuGetPackageVersion(entry);
	if (StringComparer.Ordinal.Equals(currentVersion, nextVersion))
	{
		return false;
	}

	entry.Node["version"] = nextVersion;
	return true;
}

static bool ApplyGitHubReleaseUpdate(DependencyEntry entry, string workingDirectory)
{
	if (!HasGitHubSource(entry.Source))
	{
		throw new Exception($"github-release requires source.owner, source.repo, source.rev, and source.hash for {entry.Path}");
	}

	LogStep("checking GitHub release", entry.Path);
	var source = entry.Source!;

	var owner = source["owner"]?.GetValue<string>() ?? throw new Exception($"Missing source.owner for {entry.Path}");
	var repo = source["repo"]?.GetValue<string>() ?? throw new Exception($"Missing source.repo for {entry.Path}");
	var release = GetLatestGitHubRelease(owner, repo, workingDirectory);
	var tag = release["tag_name"]?.GetValue<string>() ?? throw new Exception($"Latest GitHub release for {entry.Path} did not include tag_name");
	var changed = false;

	if (entry.Node["version"] is JsonNode versionNode)
	{
		var currentVersion = versionNode.GetValue<string>();
		var nextVersion = GetVersionFromTag(tag, entry.Update);
		if (!StringComparer.Ordinal.Equals(currentVersion, nextVersion))
		{
			entry.Node["version"] = nextVersion;
			changed = true;
		}
	}

	var currentRev = source["rev"]?.GetValue<string>() ?? throw new Exception($"Missing source.rev for {entry.Path}");
	if (!StringComparer.Ordinal.Equals(currentRev, tag))
	{
		source["rev"] = tag;
		changed = true;
	}

	return changed;
}

static JsonObject GetLatestGitHubRelease(string owner, string repo, string workingDirectory)
{
	var result = RunProcess("gh", ["api", $"repos/{owner}/{repo}/releases/latest"], workingDirectory);
	if (result.ExitCode == 0)
	{
		return JsonNode.Parse(result.StdOut) as JsonObject ?? throw new Exception($"Expected GitHub release payload for {owner}/{repo}");
	}

	if (result.StdErr.Contains("HTTP 404", StringComparison.Ordinal))
	{
		return new JsonObject
		{
			["tag_name"] = GetLatestGitHubTag(owner, repo, workingDirectory),
		};
	}

	throw new Exception($"Command failed: gh api repos/{owner}/{repo}/releases/latest{Environment.NewLine}{result.StdErr}".TrimEnd());
}

static string GetLatestGitHubTag(string owner, string repo, string workingDirectory)
{
	var output = RunAndCapture("gh", ["api", $"repos/{owner}/{repo}/tags?per_page=1"], workingDirectory);
	var tags = JsonNode.Parse(output) as JsonArray ?? throw new Exception($"Expected GitHub tags payload for {owner}/{repo}");
	var tag = tags[0] as JsonObject ?? throw new Exception($"Expected at least one GitHub tag for {owner}/{repo}");
	return tag["name"]?.GetValue<string>() ?? throw new Exception($"Missing tag name for {owner}/{repo}");
}

static string GetGitHubBranchHead(string owner, string repo, string branch, string workingDirectory)
{
	var output = RunAndCapture("gh", [$"api", $"repos/{owner}/{repo}/commits/{branch}"], workingDirectory);
	var json = JsonNode.Parse(output) as JsonObject ?? throw new Exception($"Expected GitHub commit payload for {owner}/{repo}@{branch}");
	return json["sha"]?.GetValue<string>() ?? throw new Exception($"Missing sha for {owner}/{repo}@{branch}");
}

static string GetLatestNuGetPackageVersion(DependencyEntry entry)
{
	var packageId = entry.Update["packageId"]?.GetValue<string>() ?? entry.Path;
	var versionPrefix = entry.Update["version"]?["prefix"]?.GetValue<string>();
	var packageBaseAddress = GetNuGetPackageBaseAddress();
	var lowerPackageId = packageId.ToLowerInvariant();
	var url = $"{packageBaseAddress.TrimEnd('/')}/{Uri.EscapeDataString(lowerPackageId)}/index.json";
	var json = GetJsonObject(url);
	var versions = json["versions"] as JsonArray ?? throw new Exception($"Expected NuGet versions array for {packageId}");

	var latestVersion = versions
		.Select(x => x?.GetValue<string>() ?? throw new Exception($"Invalid NuGet version entry for {packageId}"))
		.Where(x => !x.Contains('-', StringComparison.Ordinal))
		.Where(x => string.IsNullOrEmpty(versionPrefix) || x.StartsWith(versionPrefix, StringComparison.Ordinal))
		.LastOrDefault();

	return latestVersion ?? throw new Exception($"Could not find a stable NuGet version for {packageId}");
}

static bool ApplyNpmRegistryReleaseUpdate(DependencyEntry entry, string workingDirectory)
{
	LogStep("checking npm release", entry.Path);
	var packageId = entry.Update["packageId"]?.GetValue<string>() ?? throw new Exception($"Missing update.packageId for {entry.Path}");
	var version = GetLatestNpmPackageVersion(entry.Update, packageId);
	var changed = false;

	var currentVersion = entry.Node["version"]?.GetValue<string>() ?? throw new Exception($"Missing version for {entry.Path}");
	if (!StringComparer.Ordinal.Equals(currentVersion, version))
	{
		entry.Node["version"] = version;
		changed = true;
	}

	var sourcePackages = entry.Update["sourcePackages"] as JsonObject ?? throw new Exception($"Missing update.sourcePackages for {entry.Path}");
	var source = entry.Source ?? throw new Exception($"Missing source for {entry.Path}");

	foreach (var kvp in sourcePackages)
	{
		var system = kvp.Key;
		var systemPackageId = kvp.Value?.GetValue<string>() ?? throw new Exception($"Invalid source package mapping for {entry.Path}.{system}");
		LogStep($"prefetching {system} tarball", entry.Path);
		var tarballUrl = GetNpmTarballUrl(systemPackageId, version);
		var tarballHash = PrefetchFileHash(tarballUrl, workingDirectory);

		if (source[system] is not JsonObject systemSource)
		{
			throw new Exception($"Missing source entry for {entry.Path}.{system}");
		}

		var currentUrl = systemSource["url"]?.GetValue<string>() ?? throw new Exception($"Missing source url for {entry.Path}.{system}");
		var currentHash = systemSource["hash"]?.GetValue<string>() ?? throw new Exception($"Missing source hash for {entry.Path}.{system}");
		if (!StringComparer.Ordinal.Equals(currentUrl, tarballUrl))
		{
			systemSource["url"] = tarballUrl;
			changed = true;
		}

		if (!StringComparer.Ordinal.Equals(currentHash, tarballHash))
		{
			systemSource["hash"] = tarballHash;
			changed = true;
		}
	}

	return changed;
}

static string GetLatestNpmPackageVersion(JsonObject update, string packageId)
{
	var distTag = update["distTag"]?.GetValue<string>() ?? "latest";
	var metadata = GetJsonObject(GetNpmPackageMetadataUrl(packageId));
	var distTags = metadata["dist-tags"] as JsonObject ?? throw new Exception($"Expected dist-tags for npm package {packageId}");
	return distTags[distTag]?.GetValue<string>() ?? throw new Exception($"Could not find npm dist-tag '{distTag}' for {packageId}");
}

static string GetNpmTarballUrl(string packageId, string version)
{
	var metadata = GetJsonObject(GetNpmPackageMetadataUrl(packageId));
	var versions = metadata["versions"] as JsonObject ?? throw new Exception($"Expected versions object for npm package {packageId}");
	var versionMetadata = versions[version] as JsonObject ?? throw new Exception($"Could not find npm version {version} for {packageId}");
	return versionMetadata["dist"]?["tarball"]?.GetValue<string>() ?? throw new Exception($"Could not find tarball URL for {packageId}@{version}");
}

static string GetNpmPackageMetadataUrl(string packageId)
{
	return $"{NpmRegistryUrl}/{Uri.EscapeDataString(packageId)}";
}

static string GetNuGetPackageBaseAddress()
{
	var serviceIndex = GetJsonObject(NuGetServiceIndexUrl);
	var resources = serviceIndex["resources"] as JsonArray ?? throw new Exception("Expected NuGet service index resources array");
	var packageBaseAddress = resources
		.Select(x => x as JsonObject)
		.FirstOrDefault(x => x?["@type"]?.GetValue<string>()?.StartsWith("PackageBaseAddress/", StringComparison.Ordinal) == true)?["@id"]?.GetValue<string>();

	return packageBaseAddress ?? throw new Exception("Could not find NuGet PackageBaseAddress resource");
}

static JsonObject GetJsonObject(string url)
{
	using var httpClient = new HttpClient();
	using var request = new HttpRequestMessage(HttpMethod.Get, url);
	using var response = httpClient.Send(request);
	response.EnsureSuccessStatusCode();
	var content = response.Content.ReadAsStringAsync().GetAwaiter().GetResult();
	return JsonNode.Parse(content) as JsonObject ?? throw new Exception($"Expected JSON object from {url}");
}

static string GetVersionFromTag(string tag, JsonObject? update)
{
	if (update?["version"] is not JsonObject version)
	{
		return tag;
	}

	var stripPrefix = version["stripPrefix"]?.GetValue<string>();
	if (!string.IsNullOrEmpty(stripPrefix) && tag.StartsWith(stripPrefix, StringComparison.Ordinal))
	{
		return tag[stripPrefix.Length..];
	}

	return tag;
}

static PrefetchedSource PrefetchSource(JsonObject source, string workingDirectory)
{
	var owner = Uri.EscapeDataString(source["owner"]?.GetValue<string>() ?? throw new Exception("Missing source.owner"));
	var repo = Uri.EscapeDataString(source["repo"]?.GetValue<string>() ?? throw new Exception("Missing source.repo"));
	var rev = Uri.EscapeDataString(source["rev"]?.GetValue<string>() ?? throw new Exception("Missing source.rev"));
	var url = $"https://github.com/{owner}/{repo}/archive/{rev}.tar.gz";
	var output = RunAndCapture("nix", ["store", "prefetch-file", "--json", "--unpack", url], workingDirectory);
	var json = JsonNode.Parse(output) as JsonObject ?? throw new Exception("Expected prefetch output to be a JSON object");
	return new PrefetchedSource(
		json["hash"]?.GetValue<string>() ?? throw new Exception($"Missing hash in prefetch output for {url}"),
		json["storePath"]?.GetValue<string>() ?? throw new Exception($"Missing storePath in prefetch output for {url}"));
}

static string PrefetchFileHash(string url, string workingDirectory)
{
	var output = RunAndCapture("nix", ["store", "prefetch-file", "--json", url], workingDirectory);
	var json = JsonNode.Parse(output) as JsonObject ?? throw new Exception("Expected prefetch output to be a JSON object");
	return json["hash"]?.GetValue<string>() ?? throw new Exception($"Missing hash in prefetch output for {url}");
}

static string ResolveHashField(string repoRoot, string packageRoot, DependencyEntry entry, string field, string depsFile, JsonObject data, string? prefetchedSourcePath)
{
	return field switch
	{
		"npmDepsHash" when prefetchedSourcePath is not null => ResolveNpmDepsHash(entry, prefetchedSourcePath, repoRoot),
		_ => ResolveBuildHash(repoRoot, packageRoot, entry, field, depsFile, data),
	};
}

static string ResolveNpmDepsHash(DependencyEntry entry, string sourceRoot, string workingDirectory)
{
	LogStep("prefetching npm dependencies", entry.Path);
	var lockfilePath = GetNpmLockfilePath(entry, sourceRoot);
	var executable = GetPrefetchNpmDepsExecutable(workingDirectory);
	return RunAndCapture(executable, [lockfilePath], workingDirectory).Trim();
}

static string GetNpmLockfilePath(DependencyEntry entry, string sourceRoot)
{
	if (entry.Update["lockfile"] is JsonValue lockfileValue)
	{
		var lockfilePath = Path.Combine(sourceRoot, lockfileValue.GetValue<string>());
		if (File.Exists(lockfilePath))
		{
			return lockfilePath;
		}

		throw new Exception($"Configured npm lockfile was not found for {entry.Path}: {lockfilePath}");
	}

	foreach (var candidate in new[] {"package-lock.json", "npm-shrinkwrap.json"})
	{
		var candidatePath = Path.Combine(sourceRoot, candidate);
		if (File.Exists(candidatePath))
		{
			return candidatePath;
		}
	}

	throw new Exception($"Could not find an npm lockfile for {entry.Path}. Set update.lockfile to the relative path if it is not at the repository root.");
}

static string GetPrefetchNpmDepsExecutable(string workingDirectory)
{
	var packagePath = RunAndCapture("nix", ["build", "nixpkgs#prefetch-npm-deps", "--no-link", "--print-out-paths"], workingDirectory).Trim();
	var executable = Path.Combine(packagePath, "bin", "prefetch-npm-deps");
	if (!File.Exists(executable))
	{
		throw new Exception($"Could not find prefetch-npm-deps executable in {packagePath}");
	}

	return executable;
}

static string ResolveBuildHash(string repoRoot, string packageRoot, DependencyEntry entry, string field, string depsFile, JsonObject data)
{
	entry.Node[field] = FakeHash;
	WriteDependencies(depsFile, data);

	LogStep($"running nix build for {field}", entry.Path);
	var result = RunProcess("nix", ["build", $"{packageRoot}.{entry.PackageAttr}", "--no-link"], repoRoot);
	if (result.ExitCode == 0)
	{
		throw new Exception($"Expected nix build to report a replacement hash for {entry.Path}.{field}, but the build succeeded");
	}

	var resolvedHash = ExtractHash(result.StdOut + Environment.NewLine + result.StdErr);
	if (resolvedHash is null)
	{
		throw new Exception($"Could not extract replacement hash for {entry.Path}.{field}{Environment.NewLine}{result.StdErr}".TrimEnd());
	}

	return resolvedHash;
}

static void LogStep(string action, string path)
{
	Console.WriteLine($"{action}: {path}");
}

static string? ExtractHash(string text)
{
	var match = Regex.Match(text, @"got:\s*(sha256-[A-Za-z0-9+/=]+|[0-9a-z]{52})", RegexOptions.Multiline);
	return match.Success ? match.Groups[1].Value : null;
}

static string GetPackageRoot()
{
	return $".#packages.{GetNixSystem()}";
}

static string GetNixSystem()
{
	var arch = RuntimeInformation.ProcessArchitecture switch
	{
		Architecture.Arm64 => "aarch64",
		Architecture.X64 => "x86_64",
		_ => throw new Exception($"Unsupported architecture: {RuntimeInformation.ProcessArchitecture}"),
	};

	if (OperatingSystem.IsMacOS())
	{
		return $"{arch}-darwin";
	}

	if (OperatingSystem.IsLinux())
	{
		return $"{arch}-linux";
	}

	throw new Exception("update-dependencies is only supported on macOS and Linux");
}

static void WriteDependencies(string depsFile, JsonObject data)
{
	File.WriteAllText(depsFile, Render(data) + Environment.NewLine, new UTF8Encoding(false));
}

static ProcessResult RunProcess(string fileName, IReadOnlyList<string> arguments, string workingDirectory)
{
	var psi = new ProcessStartInfo(fileName)
	{
		RedirectStandardOutput = true,
		RedirectStandardError = true,
		UseShellExecute = false,
		WorkingDirectory = workingDirectory,
	};

	foreach (var argument in arguments)
	{
		psi.ArgumentList.Add(argument);
	}

	using var process = Process.Start(psi) ?? throw new Exception($"Failed to start {fileName}");
	var stdout = process.StandardOutput.ReadToEnd();
	var stderr = process.StandardError.ReadToEnd();
	process.WaitForExit();
	return new ProcessResult(process.ExitCode, stdout, stderr);
}

static string RunAndCapture(string fileName, IReadOnlyList<string> arguments, string workingDirectory)
{
	var result = RunProcess(fileName, arguments, workingDirectory);
	if (result.ExitCode != 0)
	{
		throw new Exception($"Command failed: {fileName} {string.Join(" ", arguments)}{Environment.NewLine}{result.StdErr}".TrimEnd());
	}

	return result.StdOut;
}

static string Render(JsonNode? node, int indent = 0)
{
	return node switch
	{
		JsonObject obj => RenderObject(obj, indent),
		JsonArray array => RenderArray(array, indent),
		JsonValue value => RenderValue(value),
		null => "null",
		_ => throw new NotSupportedException($"Unsupported JSON node type: {node.GetType().Name}"),
	};
}

static string RenderObject(JsonObject obj, int indent)
{
	if (obj.Count == 0)
	{
		return "{}";
	}

	var pad = new string(' ', indent + 2);
	var closingPad = new string(' ', indent);
	var lines = new List<string> {"{"};

	foreach (var kvp in obj)
	{
		lines.Add($"{pad}{RenderAttrName(kvp.Key)} = {Render(kvp.Value, indent + 2)};");
	}

	lines.Add($"{closingPad}}}");
	return string.Join(Environment.NewLine, lines);
}

static string RenderArray(JsonArray array, int indent)
{
	if (array.Count == 0)
	{
		return "[]";
	}

	var pad = new string(' ', indent + 2);
	var closingPad = new string(' ', indent);
	var lines = new List<string> {"["};

	foreach (var item in array)
	{
		lines.Add($"{pad}{Render(item, indent + 2)}");
	}

	lines.Add($"{closingPad}]");
	return string.Join(Environment.NewLine, lines);
}

static string RenderValue(JsonValue value)
{
	if (value.TryGetValue<string>(out var stringValue))
	{
		return RenderString(stringValue);
	}

	if (value.TryGetValue<bool>(out var boolValue))
	{
		return boolValue ? "true" : "false";
	}

	if (value.TryGetValue<int>(out var intValue))
	{
		return intValue.ToString(System.Globalization.CultureInfo.InvariantCulture);
	}

	if (value.TryGetValue<long>(out var longValue))
	{
		return longValue.ToString(System.Globalization.CultureInfo.InvariantCulture);
	}

	if (value.TryGetValue<decimal>(out var decimalValue))
	{
		return decimalValue.ToString(System.Globalization.CultureInfo.InvariantCulture);
	}

	if (value.TryGetValue<double>(out var doubleValue))
	{
		return doubleValue.ToString(System.Globalization.CultureInfo.InvariantCulture);
	}

	if (value.TryGetValue<JsonElement>(out var element))
	{
		return element.GetRawText();
	}

	throw new NotSupportedException($"Unsupported JSON value type: {value}");
}

static string RenderAttrName(string name)
{
	return Regex.IsMatch(name, @"^[A-Za-z_][A-Za-z0-9_-]*$")
		? name
		: RenderString(name);
}

static string RenderString(string value)
{
	var escaped = value
		.Replace("\\", "\\\\", StringComparison.Ordinal)
		.Replace("\"", "\\\"", StringComparison.Ordinal)
		.Replace("\n", "\\n", StringComparison.Ordinal)
		.Replace("\r", "\\r", StringComparison.Ordinal)
		.Replace("\t", "\\t", StringComparison.Ordinal)
		.Replace("${", "\\${", StringComparison.Ordinal);

	return $"\"{escaped}\"";
}

sealed record DependencyEntry(string Path, JsonObject Node, JsonObject? Source, JsonObject Update)
{
	public string PackageAttr => Update["packageAttr"]?.GetValue<string>() ?? Path;

	public IReadOnlyList<string> HashFields =>
		Update["hashFields"] is JsonArray hashFields
			? hashFields.Select(x => x?.GetValue<string>() ?? throw new Exception($"Invalid hash field for {Path}")).ToList()
			: [];
}

sealed record PrefetchedSource(string Hash, string StorePath);

sealed record ProcessResult(int ExitCode, string StdOut, string StdErr);
