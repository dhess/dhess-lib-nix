self: super:

let

  selfIpaddr = (import ../../lib/ipaddr) { pkgs = super; };

in
{
  lib = (super.lib or {}) // {
    ipaddr = (super.lib.ipaddr or {}) // selfIpaddr;
  };
}
