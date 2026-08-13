{
  description = "Adam's custom Nix packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    cielo = {
      url = "github:adampoit/cielo-cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    googleworkspace-cli = {
      url = "github:googleworkspace/cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wezterm-fork.url = "github:adampoit/wezterm?dir=nix";
  };

  outputs = {
    cielo,
    googleworkspace-cli,
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
    ];
    forEachSystem = f: lib.genAttrs systems f;
    packageNames = [
      "aspire-cli"
      "cielo"
      "cortexapps-cli"
      "dotnet-counters"
      "dotnet-trace"
      "findreplacecode"
      "gh-workflow-stats"
      "googleworkspace-cli"
      "jj-navi"
      "octoscope"
      "playwright-cli"
      "repo-conventions"
      "skills-ref"
      "taskwarrior-tui"
      "vscode-firefox-debug"
      "wezterm"
      "zsh-yarn-autocompletions"
    ];
    neovimPluginNames = [
      "jj-diffconflicts"
      "screenkey"
      "ts-error-translator"
    ];
    weztermPluginNames = [
      "dev-wezterm"
      "resurrect-wezterm"
      "smart-workspace-switcher-wezterm"
      "tabline-wez"
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
      weztermPlugins = lib.genAttrs weztermPluginNames (name: dependencies.${name});
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

    overlays.default = import ./pkgs/overlay.nix {
      inherit cielo googleworkspace-cli wezterm-fork;
    };

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
