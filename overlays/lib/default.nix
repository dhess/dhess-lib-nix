self: super:

let

  selfAttrsets = (import ../../lib/attrsets) { pkgs = super; };
  selfCustomisation = (import ../../lib/customisation) { pkgs = super; };
  selfDhall = (import ../../lib/dhall) { pkgs = super; };
  selfDhessLibNix = (import ../../lib/dhess-lib-nix) { pkgs = super; };
  selfDns = (import ../../lib/dns) { pkgs = super; };
  selfEmacs = (import ../../lib/emacs) { pkgs = super; };
  selfIpaddr = (import ../../lib/ipaddr) { pkgs = super; };
  selfMaintainers = (import ../../lib/maintainers) { pkgs = super; };
  selfSecurity = (import ../../lib/security) { pkgs = super; };
  selfTesting = (import ../../lib/testing) { pkgs = super; };
  selfTypes = (import ../../lib/types) { pkgs = super; };

  cleanSource = (import ../../lib/clean-source.nix) { pkgs = super; };
  directory = (import ../../lib/directory.nix) { pkgs = super; };
  operators = (import ../../lib/operators.nix) { pkgs = super; };
  secrets = (import ../../lib/secrets.nix) { pkgs = super; };

in
{
  lib = (super.lib or {}) // {
    attrsets = (super.lib.attrsets or {}) // selfAttrsets;
    customisation = (super.lib.customisation or {}) // selfCustomisation;
    dhall = (super.lib.dhall or {}) // selfDhall;
    dhess-lib-nix = (super.lib.types or {}) // selfDhessLibNix;
    dns = (super.lib.dns or {}) // selfDns;
    emacs = (super.lib.emacs or {}) // selfEmacs;
    ipaddr = (super.lib.ipaddr or {}) // selfIpaddr;
    maintainers = (super.lib.maintainers or {}) // selfMaintainers;
    security = (super.lib.security or {}) // selfSecurity;
    testing = (super.lib.testing or {}) // selfTesting;
    types = (super.lib.types or {}) // selfTypes;
  }
  // cleanSource
  // directory
  // operators
  // secrets
  ;
}
