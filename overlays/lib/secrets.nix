self: super:

let

  secrets = (import ../../lib/secrets.nix) { pkgs = super; };

in
{
  lib = (super.lib or {}) // secrets;
}
