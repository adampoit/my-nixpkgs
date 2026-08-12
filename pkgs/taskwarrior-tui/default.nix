{
  dependencies,
  fetchFromGitHub,
  installShellFiles,
  lib,
  rustPlatform,
}: let
  dep = dependencies.taskwarrior-tui;
in
  rustPlatform.buildRustPackage {
    pname = "taskwarrior-tui";
    inherit (dep) version cargoHash;

    src = fetchFromGitHub dep.source;

    nativeBuildInputs = [installShellFiles];

    doCheck = false;

    postInstall = ''
      installShellCompletion completions/taskwarrior-tui.{bash,fish} --zsh completions/_taskwarrior-tui
    '';

    meta = {
      description = "Terminal user interface for Taskwarrior";
      homepage = "https://github.com/adampoit/taskwarrior-tui";
      license = lib.licenses.mit;
      mainProgram = "taskwarrior-tui";
    };
  }
