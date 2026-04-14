{
  azure-ai-inference,
  dependencies,
  fetchurl,
  lib,
  python3Packages,
}: let
  dep = dependencies.llm-github-models;
in
  python3Packages.buildPythonPackage rec {
    pname = "llm-github-models";
    inherit (dep) version;
    pyproject = true;

    src = fetchurl {
      inherit (dep.source) hash url;
    };

    build-system = with python3Packages; [setuptools];

    propagatedBuildInputs = with python3Packages; [
      aiohttp
      azure-ai-inference
      llm
    ];

    pythonImportsCheck = ["llm_github_models"];

    meta = {
      description = "LLM plugin to access GitHub Models API";
      homepage = "https://github.com/tonybaloney/llm-github-models";
      license = lib.licenses.asl20;
    };
  }
