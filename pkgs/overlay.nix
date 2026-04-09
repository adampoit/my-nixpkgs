let
  dependencies = import ./dependencies.nix;
in
  final: _prev: {
    cortexapps-cli = final.callPackage ./cortexapps-cli {inherit dependencies;};
    dotnet-counters = final.callPackage ./dotnet-counters {inherit dependencies;};
    dotnet-trace = final.callPackage ./dotnet-trace {inherit dependencies;};
    findreplacecode = final.callPackage ./findreplacecode {inherit dependencies;};
    gh-workflow-stats = final.callPackage ./gh-workflow-stats {inherit dependencies;};
    github-copilot-cli = final.callPackage ./github-copilot-cli {inherit dependencies;};
    playwright-cli = final.callPackage ./playwright-cli {inherit dependencies;};
    skills-ref = final.callPackage ./skills-ref {inherit dependencies;};
    vscode-firefox-debug = final.callPackage ./vscode-firefox-debug {inherit dependencies;};
    zsh-yarn-autocompletions = final.callPackage ./zsh-yarn-autocompletions {inherit dependencies;};
  }
