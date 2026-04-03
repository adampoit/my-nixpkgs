#!/usr/bin/env dotnet

using System.Diagnostics;
using System.Text;
using System.Text.Json.Nodes;
using System.Text.RegularExpressions;

const string DefaultAssignee = "adampoit";

var dryRun = args.Contains("--dry-run", StringComparer.Ordinal);
var currentDirectory = Directory.GetCurrentDirectory();
var repoRoot = File.Exists(Path.Combine(currentDirectory, "pkgs", "dependencies.nix"))
	? currentDirectory
	: Path.GetFullPath(Path.Combine(currentDirectory, ".."));

var repo = GetRepositoryName(repoRoot);
var assignee = Environment.GetEnvironmentVariable("GITHUB_ASSIGNEE") ?? DefaultAssignee;
var desiredIssues = GetDesiredIssues(repoRoot);
var existingIssues = GetManagedIssues(repoRoot, repo);

foreach (var issue in desiredIssues.Values.OrderBy(x => x.Package, StringComparer.Ordinal))
{
	if (existingIssues.TryGetValue(issue.Package, out var existing))
	{
		var needsAssignee = !existing.Assignees.Contains(assignee, StringComparer.Ordinal);
		if (StringComparer.Ordinal.Equals(existing.Title, issue.Title) && StringComparer.Ordinal.Equals(existing.Body, issue.Body) && !needsAssignee)
		{
			Console.WriteLine($"ok: {issue.Package}");
			continue;
		}

		if (dryRun)
		{
			Console.WriteLine($"would update issue #{existing.Number} for {issue.Package}");
			continue;
		}

		Console.WriteLine($"updating issue #{existing.Number} for {issue.Package}");
		RunAndCapture("gh", ["issue", "edit", existing.Number.ToString(), "--title", issue.Title, "--body", issue.Body], repoRoot);
		if (needsAssignee)
		{
			RunAndCapture("gh", ["issue", "edit", existing.Number.ToString(), "--add-assignee", assignee], repoRoot);
		}
		continue;
	}

	if (dryRun)
	{
		Console.WriteLine($"would create issue for {issue.Package}");
		continue;
	}

	Console.WriteLine($"creating issue for {issue.Package}");
	RunAndCapture("gh", ["issue", "create", "--title", issue.Title, "--body", issue.Body, "--assignee", assignee], repoRoot);
}

foreach (var staleIssue in existingIssues.Values.Where(x => !desiredIssues.ContainsKey(x.Package)).OrderBy(x => x.Package, StringComparer.Ordinal))
{
	if (dryRun)
	{
		Console.WriteLine($"would close issue #{staleIssue.Number} for {staleIssue.Package}");
		continue;
	}

	Console.WriteLine($"closing issue #{staleIssue.Number} for {staleIssue.Package}");
	RunAndCapture("gh", ["issue", "close", staleIssue.Number.ToString(), "--comment", "Closing because this package is no longer detected in upstream nixpkgs."], repoRoot);
}

static string GetRepositoryName(string workingDirectory)
{
	var output = RunAndCapture("gh", ["repo", "view", "--json", "nameWithOwner"], workingDirectory);
	var json = JsonNode.Parse(output) as JsonObject ?? throw new Exception("Expected gh repo view output to be a JSON object");
	return json["nameWithOwner"]?.GetValue<string>() ?? throw new Exception("Missing nameWithOwner from gh repo view");
}

static Dictionary<string, DesiredIssue> GetDesiredIssues(string workingDirectory)
{
	var output = RunAndCapture("nix", ["eval", "--json", ".#lib.upstreamAvailability"], workingDirectory);
	var json = JsonNode.Parse(output) as JsonObject ?? throw new Exception("Expected upstream availability output to be a JSON object");
	var packages = new Dictionary<string, SortedDictionary<string, SortedSet<string>>>(StringComparer.Ordinal);

	foreach (var systemEntry in json)
	{
		var packageChecks = systemEntry.Value as JsonObject ?? throw new Exception($"Expected package checks object for {systemEntry.Key}");
		foreach (var packageEntry in packageChecks)
		{
			var availability = ParseAvailability(packageEntry.Key, packageEntry.Value);
			if (!availability.Available)
			{
				continue;
			}

			if (!packages.TryGetValue(packageEntry.Key, out var systems))
			{
				systems = new SortedDictionary<string, SortedSet<string>>(StringComparer.Ordinal);
				packages.Add(packageEntry.Key, systems);
			}

			if (!systems.TryGetValue(systemEntry.Key, out var candidates))
			{
				candidates = new SortedSet<string>(StringComparer.Ordinal);
				systems.Add(systemEntry.Key, candidates);
			}

			foreach (var candidate in availability.Candidates)
			{
				candidates.Add(string.Join(".", candidate));
			}
		}
	}

	return packages.ToDictionary(
		kvp => kvp.Key,
		kvp => new DesiredIssue(kvp.Key, GetIssueTitle(kvp.Key), RenderIssueBody(kvp.Key, kvp.Value)),
		StringComparer.Ordinal);
}

static UpstreamAvailability ParseAvailability(string path, JsonNode? node)
{
	var check = node as JsonObject ?? throw new Exception($"Expected upstream availability object for {path}");
	var available = check["available"]?.GetValue<bool>() ?? throw new Exception($"Missing upstream availability flag for {path}");
	var candidates = check["candidates"] as JsonArray ?? throw new Exception($"Missing upstream candidates for {path}");
	return new UpstreamAvailability(
		available,
		candidates.Select(candidate => ParseCandidate(path, candidate)).ToList());
}

static IReadOnlyList<string> ParseCandidate(string path, JsonNode? node)
{
	var candidate = node as JsonObject ?? throw new Exception($"Expected upstream candidate object for {path}");
	var attrPath = candidate["attrPath"] as JsonArray ?? throw new Exception($"Missing upstream attrPath for {path}");
	return attrPath.Select(x => x?.GetValue<string>() ?? throw new Exception($"Invalid upstream attrPath component for {path}")).ToList();
}

static string GetIssueTitle(string package)
{
	return $"Package now available in upstream nixpkgs: {package}";
}

static string RenderIssueBody(string package, IReadOnlyDictionary<string, SortedSet<string>> systems)
{
	var builder = new StringBuilder();
	builder.AppendLine($"<!-- upstream-package:{package} -->");
	builder.AppendLine();
	builder.AppendLine($"Upstream nixpkgs appears to provide `{package}`.");
	builder.AppendLine();
	builder.AppendLine("## Candidate attrs");

	foreach (var system in systems)
	{
		builder.AppendLine($"- `{system.Key}`: {string.Join(", ", system.Value.Select(value => $"`{value}`"))}");
	}

	builder.AppendLine();
	builder.AppendLine("This issue is managed by `scripts/sync-upstream-issues.cs`.");
	return builder.ToString().TrimEnd();
}

static Dictionary<string, ManagedIssue> GetManagedIssues(string workingDirectory, string repo)
{
	var output = RunAndCapture("gh", ["api", $"repos/{repo}/issues?state=open&per_page=100"], workingDirectory);
	var issues = JsonNode.Parse(output) as JsonArray ?? throw new Exception("Expected GitHub issues response to be an array");
	var managedIssues = new Dictionary<string, ManagedIssue>(StringComparer.Ordinal);

	foreach (var issueNode in issues)
	{
		if (issueNode is not JsonObject issue || issue["pull_request"] is JsonObject)
		{
			continue;
		}

		var body = issue["body"]?.GetValue<string>() ?? string.Empty;
		var package = GetManagedPackage(body);
		if (package is null)
		{
			continue;
		}

		managedIssues[package] = new ManagedIssue(
			issue["number"]?.GetValue<int>() ?? throw new Exception("Missing issue number"),
			issue["title"]?.GetValue<string>() ?? throw new Exception("Missing issue title"),
			body,
			(issue["assignees"] as JsonArray ?? []).Select(ParseAssignee).ToList(),
			package);
	}

	return managedIssues;
}

static string? GetManagedPackage(string body)
{
	var match = Regex.Match(body, @"<!--\s*upstream-package:([^\s>]+)\s*-->", RegexOptions.Multiline);
	return match.Success ? match.Groups[1].Value : null;
}

static string ParseAssignee(JsonNode? node)
{
	var assignee = node as JsonObject ?? throw new Exception("Expected assignee to be an object");
	return assignee["login"]?.GetValue<string>() ?? throw new Exception("Missing assignee login");
}

static string RunAndCapture(string fileName, IReadOnlyList<string> arguments, string workingDirectory)
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

	if (process.ExitCode != 0)
	{
		throw new Exception($"Command failed: {fileName} {string.Join(" ", arguments)}{Environment.NewLine}{stderr}".TrimEnd());
	}

	return stdout;
}

sealed record DesiredIssue(string Package, string Title, string Body);

sealed record ManagedIssue(int Number, string Title, string Body, IReadOnlyList<string> Assignees, string Package);

sealed record UpstreamAvailability(bool Available, IReadOnlyList<IReadOnlyList<string>> Candidates);
