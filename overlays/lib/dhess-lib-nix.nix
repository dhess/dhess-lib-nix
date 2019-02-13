self: super:

let

  selfDhessLibNix = (import ../../lib/dhess-lib-nix) { pkgs = super; };

in
{
  lib = (super.lib or {}) // {
    dhess-lib-nix = (super.lib.types or {}) // selfDhessLibNix;
  };
}
