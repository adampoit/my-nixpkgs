{
  dependencies,
  fetchurl,
  lib,
  python3Packages,
}: let
  dep = dependencies.cortexapps-cli;
in
  python3Packages.buildPythonApplication {
    pname = "cortexapps-cli";
    inherit (dep) version;
    pyproject = true;

    src = fetchurl {
      inherit (dep.source) hash url;
    };

    build-system = with python3Packages; [poetry-core];

    nativeBuildInputs = with python3Packages; [pythonRelaxDepsHook];
    pythonRelaxDeps = [
      "click"
      "requests"
      "typer"
    ];

    dependencies = with python3Packages; [
      click
      pyyaml
      requests
      typer
      typing-extensions
      urllib3
    ];

    pythonImportsCheck = ["cortexapps_cli"];

    meta = {
      description = "Command Line Interface for Cortex";
      homepage = "https://github.com/cortexapps/cli";
      license = lib.licenses.mit;
      mainProgram = "cortex";
    };
  }
