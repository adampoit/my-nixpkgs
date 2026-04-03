{
  description = "Adam's custom Nix packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    lib = nixpkgs.lib;
    dependencies = import ./pkgs/dependencies.nix;
    systems = [
      "aarch64-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    forEachSystem = f: lib.genAttrs systems f;
    packageNames = [
      "dotnet-counters"
      "dotnet-trace"
      "findreplacecode"
      "gh-workflow-stats"
      "github-copilot-cli"
      "playwright-cli"
      "skills-ref"
      "vscode-firefox-debug"
      "zsh-yarn-autocompletions"
    ];
    neovimPluginNames = [
      "jj-diffconflicts"
      "screenkey"
      "tiny-inline-diagnostic"
      "ts-error-translator"
    ];
    mkPkgs = system:
      import nixpkgs {
        inherit system;
        overlays = [self.overlays.default];
        config.allowUnfreePredicate = pkg:
          builtins.elem (lib.getName pkg) [
            "github-copilot-cli"
          ];
      };
  in {
    lib = {
      neovimPlugins = lib.genAttrs neovimPluginNames (name: dependencies.${name});
      upstreamAvailability = forEachSystem (system:
        import ./pkgs/upstream-availability.nix {
          inherit
            dependencies
            lib
            neovimPluginNames
            nixpkgs
            packageNames
            system
            ;
        });
    };

    overlays.default = import ./pkgs/overlay.nix;

    formatter = forEachSystem (system: (mkPkgs system).alejandra);

    packages = forEachSystem (
      system: let
        pkgs = mkPkgs system;
      in
        lib.genAttrs packageNames (name: pkgs.${name})
        // {
          default = pkgs.symlinkJoin {
            name = "my-nixpkgs";
            paths = map (name: pkgs.${name}) packageNames;
          };
        }
    );
  };
}
