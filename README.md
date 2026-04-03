# my-nixpkgs

Personal Nix packages not available in nixpkgs, plus a small number of intentionally newer out-of-tree variants.

## Usage

Add to your flake inputs:

```nix
{
  inputs.my-nixpkgs.url = "github:<owner>/my-nixpkgs";

  outputs = {nixpkgs, my-nixpkgs, ...}: {
    nixosConfigurations.example = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [{
        nixpkgs.overlays = [my-nixpkgs.overlays.default];
        environment.systemPackages = with pkgs; [
          playwright-cli
          gh-workflow-stats
        ];
      }];
    };
  };
}
```

Or run directly without installing:

```bash
nix run github:adampoit/my-nixpkgs#<package>
```

## License

MIT
