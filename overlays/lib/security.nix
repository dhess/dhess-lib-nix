self: super:

let

  selfSecurity = (import ../../lib/security) { pkgs = super; };

in
{
  lib = (super.lib or {}) // {
    security = (super.lib.security or {}) // selfSecurity;
  };
}
