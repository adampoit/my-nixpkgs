# my-nixpkgs

Custom Nix packages exported as a flake overlay and package set.

## Usage

Use the overlay in another flake:

```nix
{
  inputs.my-nixpkgs.url = "github:<owner>/my-nixpkgs";

  outputs = {nixpkgs, my-nixpkgs, ...}: {
    nixosConfigurations.example = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        {
          nixpkgs.overlays = [my-nixpkgs.overlays.default];
          environment.systemPackages = [
            pkgs.gh-workflow-stats
            pkgs.playwright-cli
          ];
        }
      ];
    };
  };
}
```

Or build a package directly:

```bash
nix build .#github-copilot-cli
```

## Packages

- `dotnet-counters`
- `dotnet-trace`
- `findreplacecode`
- `gh-workflow-stats`
- `github-copilot-cli`
- `playwright-cli`
- `skills-ref`
- `vscode-firefox-debug`
- `zsh-yarn-autocompletions`

## Maintenance

- `scripts/update-dependencies.cs` refreshes pinned upstream metadata in `pkgs/dependencies.nix`.
- `.github/workflows/update-dependencies.yml` runs the updater on a weekly schedule and opens a pull request when versions change.

## Development

```bash
nix flake show --all-systems
./scripts/update-dependencies.cs
```
