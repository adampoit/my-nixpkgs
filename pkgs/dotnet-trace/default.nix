{
  buildDotnetGlobalTool,
  dependencies,
  dotnetCorePackages,
}: let
  dep = dependencies.dotnet-trace;
in
  buildDotnetGlobalTool {
    pname = "dotnet-trace";
    nugetName = "dotnet-trace";
    inherit (dep) version nugetSha256;
    dotnet-sdk = dotnetCorePackages.sdk_8_0;
  }
