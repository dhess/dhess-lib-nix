let

  # Adapted from https://github.com/input-output-hk/iohk-ops/blob/e6f1ae95cdbfdd5c213aa0b9a1ef67150febc503/lib.nix

  fetchGithub = jsonSpec:
  let
    spec = builtins.fromJSON jsonSpec;
  in
    builtins.fetchTarball {
      url = "https://github.com/${spec.owner}/${spec.repo}/archive/${spec.rev}.tar.gz";
      inherit (spec) sha256;
    };

  # Fetch (from GitHub) a Nix expression (i.e., repo), as specified by
  # its revision.
  fixedNixSrc = pathOverride: jsonSpecFile:
  let
    try = builtins.tryEval (builtins.findFile builtins.nixPath pathOverride);
  in
    if try.success
      then builtins.trace "Using <${pathOverride}>" try.value
      else fetchGithub (builtins.readFile jsonSpecFile);

  fixedNixpkgs = fixedNixSrc "nixpkgs_override" ./nixpkgs-src.json;
  nixpkgs = import fixedNixpkgs;
  pkgs = nixpkgs {};
  lib = pkgs.lib;


  ## These functions are useful for building package sets from
  ## stand-alone overlay repos.

  composeOverlays = overlays: pkgSet:
  let
    toFix = lib.foldl'
              (lib.flip lib.extends)
              (lib.const pkgSet)
              overlays;
  in
    lib.fix toFix;

  composeOverlaysFromFiles = overlaysFiles: pkgSet:
    composeOverlays (map import overlaysFiles) pkgSet;

in lib // {

  ## Export from here anything that could be useful to other packages
  ## that import this one, and want to bootstrap before they can load
  ## the local overlays into their own package set.

  inherit fixedNixSrc fixedNixpkgs;
  inherit nixpkgs pkgs;
  inherit composeOverlays composeOverlaysFromFiles;
}
