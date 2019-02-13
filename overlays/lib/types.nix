self: super:

let

  selfTypes = (import ../../lib/types) { pkgs = super; };

in
{
  lib = (super.lib or {}) // {
    types = (super.lib.types or {}) // selfTypes;
  };
}
