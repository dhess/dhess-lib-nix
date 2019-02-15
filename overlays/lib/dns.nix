self: super:

let

  selfDns = (import ../../lib/dns) { pkgs = super; };

in
{
  lib = (super.lib or {}) // {
    dns = (super.lib.dns or {}) // selfDns;
  };
}
