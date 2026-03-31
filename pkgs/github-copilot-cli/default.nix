{
  autoPatchelfHook,
  dependencies,
  fetchurl,
  lib,
  makeBinaryWrapper,
  stdenv,
}: let
  dep = dependencies.github-copilot-cli;
  srcConfig =
    dep.source.${stdenv.hostPlatform.system}
    or (throw "Unsupported system: ${stdenv.hostPlatform.system}");
in
  stdenv.mkDerivation {
    pname = "github-copilot-cli";
    inherit (dep) version;

    src = fetchurl {
      inherit (srcConfig) hash url;
    };

    nativeBuildInputs = [makeBinaryWrapper] ++ lib.optionals stdenv.hostPlatform.isLinux [autoPatchelfHook];
    buildInputs = lib.optionals stdenv.hostPlatform.isLinux [stdenv.cc.cc.lib];

    sourceRoot = "package";
    dontStrip = true;

    installPhase = ''
      runHook preInstall

      install -Dm755 copilot $out/libexec/copilot

      runHook postInstall
    '';

    postInstall = ''
      makeWrapper $out/libexec/copilot $out/bin/copilot \
        --add-flags "--no-auto-update"
    '';

    meta = {
      description = "GitHub Copilot CLI brings the power of Copilot coding agent directly to your terminal";
      homepage = "https://www.npmjs.com/package/@github/copilot";
      license = lib.licenses.unfree;
      mainProgram = "copilot";
      platforms = builtins.attrNames dep.source;
    };
  }
