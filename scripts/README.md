# Scripts

Utility scripts for maintaining `my-nixpkgs`.

## update-dependencies.cs

Refresh the stored source hashes and updater-managed metadata in `pkgs/dependencies.nix`.

### Usage

```bash
./scripts/update-dependencies.cs [dependency-path...]
```

**Examples:**

```bash
# Refresh all managed entries
./scripts/update-dependencies.cs

# Refresh a single package source
./scripts/update-dependencies.cs playwright-cli

# Refresh a single package with an update strategy
./scripts/update-dependencies.cs gh-workflow-stats
```

On macOS and Linux, this works as a file-based app via the shebang in `scripts/update-dependencies.cs`.

### What It Does

- Evaluates `pkgs/dependencies.nix`
- Warns when a selected dependency appears to be available in the locked upstream `nixpkgs`
- Applies any declared `update.strategy` before refreshing hashes
- Finds entries with `source.owner`, `source.repo`, `source.rev`, and `source.hash`
- Re-prefetches each GitHub archive and rewrites the stored `source.hash` when it changes
- Recomputes any declared dependent hashes such as `vendorHash` or `npmDepsHash`

### Update Strategies

- `github-release`: query `gh` for the latest GitHub release, update `version` and `source.rev`, then refresh dependent hashes
- `github-branch`: query `gh` for the latest commit on a configured branch, update `source.rev`, then refresh the source hash
- `nuget-release`: query the NuGet V3 API for the latest stable package version, update `version`, then refresh dependent hashes
- `npm-registry-release`: query the npm registry for the latest package version, update `version`, and refresh configured tarball URLs and hashes
- `manual`: require explicit updater metadata for packages that are not automatically advanced by the script

### Upstream nixpkgs Checks

- By default, each selected dependency is matched against likely upstream attributes in the relevant scope (`pkgs` or `pkgs.vimPlugins`) using normalized package names.
- Set `update.upstream.ignore = true;` when you intentionally want to keep maintaining an out-of-tree package even though nixpkgs already has one.
- The upstream availability data is exposed for manual inspection as `.#lib.upstreamAvailability.<system>`.

### Notes

- Hash recomputation builds `packages.<current-system>.<packageAttr>` from this flake.
- Every top-level package entry in `pkgs/dependencies.nix` must define `update.strategy`.
- Entries with `strategy = "manual"` are validated and accepted by the script but left unchanged.
- The upstream availability warning only runs for the entries selected by the command-line filters.
- NuGet entries can constrain updates with `update.version.prefix` when the package should stay on a supported release line.

## Scheduled Updates

`.github/workflows/update-dependencies.yml` runs on a weekly cron, refreshes the locked `nixpkgs` input, opens a pull request only when `pkgs/dependencies.nix` changes, includes the corresponding `flake.lock` update in that pull request, and syncs per-package issues for dependencies that now appear to exist in upstream nixpkgs.
