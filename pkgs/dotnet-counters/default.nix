{
  buildDotnetGlobalTool,
  dependencies,
  dotnetCorePackages,
}: let
  dep = dependencies.dotnet-counters;
in
  buildDotnetGlobalTool {
    pname = "dotnet-counters";
    nugetName = "dotnet-counters";
    inherit (dep) version nugetSha256;
    dotnet-sdk = dotnetCorePackages.sdk_8_0;
  }
