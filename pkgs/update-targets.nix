{
  pkgs,
  dependencies,
  pluginNames,
}: let
  sourceTarget = name: dep:
    pkgs.stdenvNoCC.mkDerivation {
      pname = name;
      version = dep.version or "0-unstable";
      src = pkgs.fetchFromGitHub dep.source;
      dontBuild = true;
      installPhase = ''
        cp -R . "$out"
      '';
    };
in
  pkgs.lib.mapAttrs (
    name: dep:
      if dep.update.strategy == "nuget-release"
      then
        if dep ? platformPackages
        then
          pkgs.lib.mapAttrs (_: platform:
            pkgs.dotnetCorePackages.fetchNupkg {
              pname = platform.packageId;
              inherit (dep) version;
              inherit (platform) hash;
            })
          dep.platformPackages
        else pkgs.${name}.nupkg
      else if builtins.elem name pluginNames || name == "skills-ref"
      then sourceTarget name dep
      else pkgs.${name}
  )
  dependencies
