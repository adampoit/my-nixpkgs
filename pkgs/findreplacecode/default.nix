{
  buildDotnetGlobalTool,
  dependencies,
  dotnetCorePackages,
}: let
  dep = dependencies.findreplacecode;
in
  buildDotnetGlobalTool {
    pname = "findreplacecode";
    nugetName = "Faithlife.FindReplaceCode.Tool";
    inherit (dep) version nugetSha256;
    dotnet-sdk = dotnetCorePackages.sdk_9_0;
  }
