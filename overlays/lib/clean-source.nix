self: super:

let

  cleanSource = (import ../../lib/clean-source.nix) { pkgs = super; };

in
{
  lib = (super.lib or {}) // cleanSource;
}
