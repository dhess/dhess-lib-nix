self: super:

let

  selfDhall = (import ../../lib/dhall) { pkgs = super; };

in
{
  lib = (super.lib or {}) // {
    dhall = (super.lib.dhall or {}) // selfDhall;
  };
}
