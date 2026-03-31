{
  lib,
  dependencies,
  fetchFromGitHub,
  buildGoModule,
}: let
  dep = dependencies.gh-workflow-stats;
in
  buildGoModule rec {
    pname = "gh-workflow-stats";
    inherit (dep) version vendorHash;

    src = fetchFromGitHub dep.source;

    meta = {
      description = "gh extension to manage GitHub Actions caches";
      homepage = "https://github.com/fchimpan/gh-workflow-stats";
      changelog = "https://github.com/fchimpan/gh-workflow-stats/releases/tag/${src.rev}";
      license = lib.licenses.mit;
      mainProgram = "gh-workflow-stats";
    };
  }
