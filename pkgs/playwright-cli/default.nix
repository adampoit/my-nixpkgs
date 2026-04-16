{
  buildNpmPackage,
  cacert,
  dependencies,
  fetchFromGitHub,
  lib,
  makeWrapper,
}: let
  dep = dependencies.playwright-cli;
in
  buildNpmPackage rec {
    pname = "playwright-cli";
    inherit (dep) version npmDepsHash;

    src = fetchFromGitHub dep.source;

    makeCacheWritable = true;
    dontNpmBuild = true;

    nativeBuildInputs = [
      cacert
      makeWrapper
    ];

    postInstall = ''
      mkdir -p $out/share/opencode/skills
      cp -R skills/playwright-cli $out/share/opencode/skills/

      wrapProgram $out/bin/playwright-cli \
        --set PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD 1
    '';

    meta = with lib; {
      description = "Official Playwright CLI with bundled agent skill";
      homepage = "https://github.com/microsoft/playwright-cli";
      license = licenses.asl20;
      maintainers = [];
      mainProgram = "playwright-cli";
    };
  }
