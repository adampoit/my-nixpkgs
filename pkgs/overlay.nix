let
  dependencies = import ./dependencies.nix;
in
  final: _prev: {
    apm = final.callPackage ./apm {inherit dependencies;};
    azure-ai-inference = final.callPackage ./azure-ai-inference {inherit dependencies;};
    cortexapps-cli = final.callPackage ./cortexapps-cli {inherit dependencies;};
    dotnet-counters = final.callPackage ./dotnet-counters {inherit dependencies;};
    dotnet-trace = final.callPackage ./dotnet-trace {inherit dependencies;};
    findreplacecode = final.callPackage ./findreplacecode {inherit dependencies;};
    gh-workflow-stats = final.callPackage ./gh-workflow-stats {inherit dependencies;};
    github-copilot-cli = final.callPackage ./github-copilot-cli {inherit dependencies;};
    llm-github-models = final.callPackage ./llm-github-models {inherit dependencies;};
    playwright-cli = final.callPackage ./playwright-cli {inherit dependencies;};
    repo-conventions = final.callPackage ./repo-conventions {inherit dependencies;};
    skills-ref = final.callPackage ./skills-ref {inherit dependencies;};
    vscode-firefox-debug = final.callPackage ./vscode-firefox-debug {inherit dependencies;};
    zsh-yarn-autocompletions = final.callPackage ./zsh-yarn-autocompletions {inherit dependencies;};
  }
