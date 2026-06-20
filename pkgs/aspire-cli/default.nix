{
  buildDotnetGlobalTool,
  dependencies,
  dotnetCorePackages,
  lib,
  stdenv,
}: let
  dep = dependencies.aspire-cli;
  platformPackage = dep.platformPackages.${stdenv.hostPlatform.system}
    or (throw "Unsupported system: ${stdenv.hostPlatform.system}");
in
  buildDotnetGlobalTool {
    pname = "aspire-cli";
    nugetName = platformPackage.packageId;
    inherit (dep) version;
    nugetHash = platformPackage.hash;
    dotnet-sdk = dotnetCorePackages.sdk_10_0;
    executables = "aspire";

    meta = {
      description = ".NET Aspire CLI";
      homepage = "https://learn.microsoft.com/dotnet/aspire/cli/overview";
      license = lib.licenses.mit;
      mainProgram = "aspire";
    };
  }
