{
  lib,
  nixpkgs,
  dependencies,
  neovimPluginNames,
  packageNames,
  system,
}: let
  pkgs = nixpkgs.legacyPackages.${system};

  normalize = value: let
    chars = lib.stringToCharacters (lib.toLower value);
    kept = builtins.filter (char: builtins.match "[a-z0-9]" char != null) chars;
  in
    lib.concatStrings kept;

  stripCommonSuffixes = value:
    lib.pipe value [
      lib.toLower
      (lib.removeSuffix ".nvim")
      (lib.removeSuffix "-nvim")
      (lib.removeSuffix "_nvim")
      (lib.removeSuffix ".vim")
      (lib.removeSuffix "-vim")
      (lib.removeSuffix "_vim")
    ];

  normalizeForMatch = value: normalize (stripCommonSuffixes value);

  getScope = name:
    if builtins.elem name neovimPluginNames
    then {
      attrPath = ["vimPlugins"];
      attrs = builtins.attrNames pkgs.vimPlugins;
    }
    else if builtins.elem name packageNames
    then {
      attrPath = [];
      attrs = builtins.attrNames pkgs;
    }
    else throw "Unknown dependency scope for ${name}";

  getAliases = name: dependency:
    lib.unique (
      builtins.filter (alias: alias != "") [
        name
        (dependency.source.repo or "")
        (dependency.update.packageId or "")
        (let
          packageId = dependency.update.packageId or "";
          parts = builtins.filter (part: part != "") (lib.splitString "/" packageId);
        in
          if parts == []
          then ""
          else lib.last parts)
      ]
    );

  getCandidates = name: dependency: let
    upstream = dependency.update.upstream or {};
    scope = getScope name;
    aliases = getAliases name dependency;
    normalizedAliases = builtins.map normalizeForMatch aliases;
    matchingAttrs =
      builtins.filter (
        attr: builtins.elem (normalizeForMatch attr) normalizedAliases
      )
      scope.attrs;
  in
    builtins.map (attr: {attrPath = scope.attrPath ++ [attr];}) matchingAttrs;

  mkAvailability = name: dependency: let
    upstream = dependency.update.upstream or {};
    ignore = upstream.ignore or false;
  in
    if ignore
    then null
    else let
      candidates = getCandidates name dependency;
    in {
      available = candidates != [];
      inherit candidates;
    };
in
  lib.filterAttrs (_: value: value != null) (lib.mapAttrs mkAvailability dependencies)
