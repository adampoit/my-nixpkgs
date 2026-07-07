{
  lib,
  dependencies,
  fetchFromGitHub,
  git,
  jujutsu,
  makeWrapper,
  rustPlatform,
}: let
  dep = dependencies.jj-navi;
in
  rustPlatform.buildRustPackage rec {
    pname = "jj-navi";
    inherit (dep) version;

    src = fetchFromGitHub dep.source;

    cargoLock = {
      lockFile = "${src}/Cargo.lock";
    };

    nativeBuildInputs = [makeWrapper];

    nativeCheckInputs = [
      git
      jujutsu
    ];

    preCheck = ''
      export HOME=$TMPDIR
      export NO_COLOR=1
      unset COLUMNS
    '';

    checkFlags = [
      "--skip"
      "list_reports_large_real_diff_stats_instead_of_unknown"
      "--skip"
      "renders_combined_workspace_statuses"
    ];

    postInstall = ''
      wrapProgram $out/bin/navi \
        --prefix PATH : ${lib.makeBinPath [jujutsu]}
      wrapProgram $out/bin/nv \
        --prefix PATH : ${lib.makeBinPath [jujutsu]}
    '';

    meta = {
      description = "Workspace management for Jujutsu";
      homepage = "https://github.com/eersnington/jj-navi";
      license = lib.licenses.mit;
      mainProgram = "navi";
    };
  }
