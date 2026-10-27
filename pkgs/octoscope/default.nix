{
  buildGoModule,
  dependencies,
  fetchFromGitHub,
  lib,
}: let
  dep = dependencies.octoscope;
in
  buildGoModule rec {
    pname = "octoscope";
    inherit (dep) version vendorHash;

    src = fetchFromGitHub dep.source;
    ldflags = ["-s" "-w" "-X" "main.version=${version}"];

    meta = {
      description = "Terminal dashboard for your GitHub account";
      homepage = "https://github.com/gfazioli/octoscope";
      license = lib.licenses.mit;
      mainProgram = "octoscope";
    };
  }
