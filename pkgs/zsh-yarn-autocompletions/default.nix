{
  lib,
  dependencies,
  fetchFromGitHub,
  rustPlatform,
}: let
  dep = dependencies.zsh-yarn-autocompletions;
in
  rustPlatform.buildRustPackage rec {
    pname = "zsh-yarn-autocompletions";
    inherit (dep) version;

    src = fetchFromGitHub dep.source;

    cargoLock = {
      lockFile = "${src}/Cargo.lock";
    };

    postInstall = ''
      mkdir -p $out/share/${pname}
      cp $src/*.zsh $out/share/${pname}/
      cp $out/bin/yarn-autocompletions $out/share/${pname}/
    '';

    meta = with lib; {
      description = "Zsh plugin for Yarn autocompletions";
      homepage = "https://github.com/g-plane/zsh-yarn-autocompletions";
      license = licenses.mit;
      platforms = platforms.all;
    };
  }
