{
  dependencies,
  lib,
  python3Packages,
  fetchFromGitHub,
}: let
  dep = dependencies.skills-ref;
in
  python3Packages.buildPythonPackage {
    pname = "skills-ref";
    inherit (dep) version;
    pyproject = true;

    src = "${fetchFromGitHub dep.source}/${dep.sourceSubdir}";

    build-system = with python3Packages; [hatchling];

    dependencies = with python3Packages; [
      click
      strictyaml
    ];

    pythonImportsCheck = ["skills_ref"];

    meta = {
      description = "Reference library for Agent Skills";
      homepage = "https://github.com/agentskills/agentskills/tree/main/skills-ref";
      license = lib.licenses.asl20;
    };
  }
