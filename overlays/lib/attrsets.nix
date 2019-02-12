self: super:

let

  selfAttrsets = (import ../../lib/attrsets) { pkgs = super; };

in
{
  lib = (super.lib or {}) // {
    attrsets = (super.lib.attrsets or {}) // selfAttrsets;
  };
}
