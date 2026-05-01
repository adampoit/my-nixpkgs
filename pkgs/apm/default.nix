{
  azure-ai-inference,
  dependencies,
  fetchurl,
  lib,
  llm-github-models,
  python3Packages,
}: let
  dep = dependencies.apm;
in
  python3Packages.buildPythonApplication {
    pname = "apm";
    inherit (dep) version;
    pyproject = true;

    src = fetchurl {
      inherit (dep.source) hash url;
    };

    build-system = with python3Packages; [
      setuptools
      wheel
    ];

    propagatedBuildInputs = with python3Packages; [
      click
      colorama
      gitpython
      llm
      llm-github-models
      python-frontmatter
      pyyaml
      requests
      rich
      rich-click
      ruamel-yaml
      toml
      watchdog
    ];

    pythonImportsCheck = ["apm_cli"];

    meta = {
      description = "Agent Package Manager";
      homepage = "https://github.com/microsoft/apm";
      license = lib.licenses.mit;
      mainProgram = "apm";
    };
  }
