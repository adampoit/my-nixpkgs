{
  buildNpmPackage,
  cacert,
  chromium,
  dependencies,
  fetchFromGitHub,
  lib,
  makeWrapper,
  playwright-driver,
  stdenv,
}: let
  dep = dependencies.playwright-cli;
  wrapperArgs =
    [
      "--set"
      "PLAYWRIGHT_BROWSERS_PATH"
      "${playwright-driver.browsers}"
      "--set"
      "PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD"
      "1"
    ]
    ++ lib.optionals stdenv.isLinux [
      "--set"
      "PLAYWRIGHT_MCP_EXECUTABLE_PATH"
      "${chromium}/bin/chromium"
    ];
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

      wrapProgram $out/bin/playwright-cli ${lib.escapeShellArgs wrapperArgs}
    '';

    meta = with lib; {
      description = "Official Playwright CLI with bundled agent skill";
      homepage = "https://github.com/microsoft/playwright-cli";
      license = licenses.asl20;
      maintainers = [];
      mainProgram = "playwright-cli";
    };
  }
