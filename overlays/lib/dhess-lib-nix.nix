self: super:

let

  localLibs = import ../../lib;

  # Provide access to the whole package, if needed.
  path = ../../.;

in
{
  lib = (super.lib or {}) // {
    dhess-lib-nix = (super.lib.dhess-lib-nix or {}) // {
      inherit path;

      # Access to dhess-lib-nix's fixed nixpkgs, packages, and
      # packages plus overlays.
      inherit (localLibs) nixpkgs pkgs pkgsWithLocalOverlays;
    };
  };
}
