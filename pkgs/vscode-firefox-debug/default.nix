{
  buildNpmPackage,
  dependencies,
  fetchFromGitHub,
  pkgs,
}: let
  dep = dependencies.vscode-firefox-debug;
in
  buildNpmPackage {
    name = "vscode-firefox-debug";

    src = fetchFromGitHub dep.source;

    inherit (dep) npmDepsHash;
    makeCacheWritable = true;

    nativeBuildInputs = [
      pkgs.cacert
      pkgs.pkg-config
    ];

    buildInputs = [pkgs.libsecret];

    preInstall = ''
      export PKG_CONFIG_PATH="${pkgs.libsecret}/lib/pkgconfig:$PKG_CONFIG_PATH"
    '';

    preBuild = ''
      export PKG_CONFIG_PATH="${pkgs.libsecret}/lib/pkgconfig:$PKG_CONFIG_PATH"
    '';

    postBuild = ''
      cp -r dist/ $out
    '';
  }
