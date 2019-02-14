self: super:

let

  callOverlay = path: import path { pkgs = super; };

  overlay = {
    attrsets = callOverlay ../../lib/attrsets;
    customisation = callOverlay ../../lib/customisation;
    dhall = callOverlay ../../lib/dhall;
    dhessLibNix = callOverlay ../../lib/dhess-lib-nix;
    dns = callOverlay ../../lib/dns;
    emacs = callOverlay ../../lib/emacs;
    ipaddr = callOverlay ../../lib/ipaddr;
    maintainers = callOverlay ../../lib/maintainers;
    security = callOverlay ../../lib/security;
    testing = callOverlay ../../lib/testing;
    types = callOverlay ../../lib/types;

    cleanSource = callOverlay ../../lib/clean-source.nix;
    directory = callOverlay ../../lib/directory.nix;
    operators = callOverlay ../../lib/operators.nix;
    secrets = callOverlay ../../lib/secrets.nix;
  };

  lib = (super.lib or {}) // {
    attrsets = (super.lib.attrsets or {}) // overlay.attrsets;
    customisation = (super.lib.customisation or {}) // overlay.customisation;
    dhall = (super.lib.dhall or {}) // overlay.dhall;
    dhess-lib-nix = (super.lib.types or {}) // overlay.dhessLibNix;
    dns = (super.lib.dns or {}) // overlay.dns;
    emacs = (super.lib.emacs or {}) // overlay.emacs;
    ipaddr = (super.lib.ipaddr or {}) // overlay.ipaddr;
    maintainers = (super.lib.maintainers or {}) // overlay.maintainers;
    security = (super.lib.security or {}) // overlay.security;
    testing = (super.lib.testing or {}) // overlay.testing;
    types = (super.lib.types or {}) // overlay.types;
  }
  // overlay.cleanSource
  // overlay.directory
  // overlay.operators
  // overlay.secrets
  ;

in
{
  inherit lib;
}
