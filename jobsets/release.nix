let

  fixedNixPkgs = (import ../lib).fetchNixpkgs;

in

{ supportedSystems ? [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" ]
, scrubJobs ? true
, nixpkgsArgs ? {
    config = {allowUnfree = false; inHydra = true; };
    overlays = [
      (import ../overlays)
      (import ../tests)
    ];
  }
}:

with import (fixedNixPkgs + "/pkgs/top-level/release-lib.nix") {
  inherit supportedSystems scrubJobs nixpkgsArgs;
};

(mapTestOn (rec {
  dlnCleanSourceNix = all;
  dlnCleanSourceHaskell = all;
  dlnCleanSourceSystemCruft = all;
  dlnCleanSourceEditors = all;
  dlnCleanSourceMaintainer = all;
  dlnCleanSourceAllExtraneous = all;
  dlnCleanPackageNix = all;
  dlnCleanPackageHaskell = all;
  dlnCleanPackageSystemCruft = all;
  dlnCleanPackageEditors = all;
  dlnCleanPackageMaintainer = all;
  dlnCleanPackageAllExtraneous = all;
  dlnAttrSets = all;
  dlnIPAddr = all;
  dlnMisc = all;
  dlnFfdhe = all;
  dlnTypes = all;
}))
