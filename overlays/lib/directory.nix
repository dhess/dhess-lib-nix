self: super:

let

  directory = (import ../../lib/directory.nix) { pkgs = super; };

in
{
  lib = (super.lib or {}) // directory;
}
