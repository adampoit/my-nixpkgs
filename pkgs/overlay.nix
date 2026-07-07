{wezterm-fork}: let
  dependencies = import ./dependencies.nix;
in
  final: prev: {
    aspire-cli = final.callPackage ./aspire-cli {inherit dependencies;};
    cortexapps-cli = final.callPackage ./cortexapps-cli {inherit dependencies;};
    dotnet-counters = final.callPackage ./dotnet-counters {inherit dependencies;};
    dotnet-trace = final.callPackage ./dotnet-trace {inherit dependencies;};
    findreplacecode = final.callPackage ./findreplacecode {inherit dependencies;};
    gh-workflow-stats = final.callPackage ./gh-workflow-stats {inherit dependencies;};
    jj-navi = final.callPackage ./jj-navi {inherit dependencies;};
    pi-coding-agent = final.callPackage ./pi-coding-agent {inherit dependencies;};
    playwright-cli = final.callPackage ./playwright-cli {inherit dependencies;};
    repo-conventions = final.callPackage ./repo-conventions {inherit dependencies;};
    skills-ref = final.callPackage ./skills-ref {inherit dependencies;};
    vscode-firefox-debug = final.callPackage ./vscode-firefox-debug {inherit dependencies;};
    wezterm = wezterm-fork.packages.${prev.stdenv.hostPlatform.system}.default;
    zsh-yarn-autocompletions = final.callPackage ./zsh-yarn-autocompletions {inherit dependencies;};
  }
