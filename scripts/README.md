# Scripts

## Dependency updates

Requires .NET 10. Run from the repository root:

```bash
nix develop --command dotnet run --file scripts/update-dependencies.cs --
nix develop --command dotnet run --file scripts/update-dependencies.cs -- octoscope playwright-cli
```

The runner selects packages and update policies; [nix-update](https://github.com/Mic92/nix-update) discovers releases and edits versions, revisions, source hashes, and dependency hashes. It never commits or pushes changes. A failed package does not stop checks of the remaining packages, but the runner exits unsuccessfully if any update fails.

### Package layout

- `pkgs/<name>/sources.nix` contains one dependency's pins and update policy.
- `pkgs/dependencies.nix` imports those files, preserving the metadata consumed by package definitions and `lib.neovimPlugins` / `lib.weztermPlugins`.
- `legacyPackages.<system>.updateTargets` exposes derivations for nix-update. Plugin metadata and the `skills-ref` subdirectory use full-repository source targets; NuGet tools use their actual package downloads.

Each nix-update invocation specifies `--override-filename` to select the corresponding `sources.nix`. Do not combine multiple packages' mutable pins in one file: nix-update uses textual replacement.

For example, to refresh Octoscope's hashes without changing its version:

```bash
nix develop --command nix-update \
  legacyPackages.aarch64-darwin.updateTargets.octoscope \
  --flake --system aarch64-darwin \
  --override-filename pkgs/octoscope/sources.nix --version=skip
```

Use your current system in place of `aarch64-darwin`. The runner chooses it automatically unless passed `--system`.

### Update policies

- `github-release` and `pypi-release`: let nix-update discover the latest stable version.
- `github-branch`: pass `--version=branch=<branch>` (default `main`). Where a stored version exists, nix-update may also advance it to an unstable snapshot version.
- `nuget-release`: the C# runner discovers the latest stable NuGet version, respecting `update.version.prefix`. nix-update edits the version and refreshes every declared platform's hash, even when the version is unchanged. All platform downloads use the current system's fetchers; no cross-platform builder is required.
- `manual`: skip the dependency, including when explicitly selected.

NuGet discovery is the only registry-specific helper: nix-update does not currently discover NuGet releases. No custom hash extraction, build-error parsing, or Nix serialization is maintained here.

The upstream availability check remains available at `.#lib.upstreamAvailability.<system>`. `update.upstream.ignore = true` excludes intentionally out-of-tree packages from that check.

### Formatting

```bash
nix develop --command alejandra pkgs flake.nix
```

## Scheduled updates

`.github/workflows/update-dependencies.yml` runs daily. It refreshes flake inputs, runs the nix-update runner, formats package expressions, and syncs upstream-package issues. Changes to either `flake.lock` or `pkgs/` open or refresh the dependency pull request. Package builds remain gated by the Linux/macOS CI workflow.

## sync-upstream-issues.cs

Maintains per-package issues for packages that appear to exist in upstream nixpkgs. Requires .NET 10 and `gh` authentication.

```bash
./scripts/sync-upstream-issues.cs --dry-run
```
