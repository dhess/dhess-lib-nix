self: super:

let

  selfTesting = (import ../../lib/testing) { pkgs = super; };

in
{
  lib = (super.lib or {}) // {
    testing = (super.lib.testing or {}) // selfTesting;
  };
}
