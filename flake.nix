{
  description = "Adam's custom Nix packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    wezterm-fork.url = "github:adampoit/wezterm?dir=nix";
  };

  outputs = {
    self,
    nixpkgs,
    wezterm-fork,
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
      "aspire-cli"
      "cortexapps-cli"
      "dotnet-counters"
      "dotnet-trace"
      "findreplacecode"
      "gh-workflow-stats"
      "jj-navi"
      "pi-coding-agent"
      "playwright-cli"
      "repo-conventions"
      "skills-ref"
      "vscode-firefox-debug"
      "wezterm"
      "zsh-yarn-autocompletions"
    ];
    neovimPluginNames = [
      "jj-diffconflicts"
      "screenkey"
      "ts-error-translator"
    ];
    mkPkgs = system:
      import nixpkgs {
        inherit system;
        overlays = [self.overlays.default];
        config.allowUnfreePredicate = pkg:
          builtins.elem (lib.getName pkg) [
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

    overlays.default = import ./pkgs/overlay.nix {inherit wezterm-fork;};

    formatter = forEachSystem (system: (mkPkgs system).alejandra);

    devShells = forEachSystem (
      system: let
        pkgs = mkPkgs system;
      in {
        default = pkgs.mkShell {
          packages = [
            pkgs.actionlint
          ];
        };
      }
    );

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
