{
  dependencies,
  fetchurl,
  lib,
  python3Packages,
}: let
  dep = dependencies.azure-ai-inference;
in
  python3Packages.buildPythonPackage rec {
    pname = "azure-ai-inference";
    inherit (dep) version;
    format = "wheel";

    src = fetchurl {
      inherit (dep.source) hash url;
    };

    propagatedBuildInputs = with python3Packages; [
      azure-core
      isodate
      typing-extensions
    ];

    pythonImportsCheck = ["azure.ai.inference"];

    meta = {
      description = "Microsoft Azure AI Inference Client Library for Python";
      homepage = "https://pypi.org/project/azure-ai-inference/";
      license = lib.licenses.mit;
    };
  }
