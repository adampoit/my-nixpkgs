{
  buildDotnetGlobalTool,
  dependencies,
  dotnetCorePackages,
}: let
  dep = dependencies.repo-conventions;
in
  buildDotnetGlobalTool {
    pname = "repo-conventions";
    nugetName = "repo-conventions";
    inherit (dep) version nugetSha256;
    dotnet-sdk = dotnetCorePackages.sdk_10_0;
  }
