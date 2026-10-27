{
  dependencies,
  fetchPypi,
  lib,
  python3Packages,
}: let
  dep = dependencies.cortexapps-cli;
in
  python3Packages.buildPythonApplication {
    pname = "cortexapps-cli";
    inherit (dep) version;
    pyproject = true;

    src = fetchPypi {
      pname = "cortexapps_cli";
      inherit (dep) version;
      inherit (dep.source) hash;
    };

    build-system = with python3Packages; [poetry-core];

    nativeBuildInputs = with python3Packages; [pythonRelaxDepsHook];
    pythonRelaxDeps = [
      # nixpkgs replaces certifi's bundled roots with its separately maintained cacert bundle.
      "certifi"
      "click"
      "requests"
      "typer"
      "urllib3"
    ];

    dependencies = with python3Packages; [
      certifi
      click
      pyyaml
      pynacl
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
