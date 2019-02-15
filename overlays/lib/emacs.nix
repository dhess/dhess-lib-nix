self: super:

let

  selfEmacs = (import ../../lib/emacs) { pkgs = super; };

in
{
  lib = (super.lib or {}) // {
    emacs = (super.lib.emacs or {}) // selfEmacs;
  };
}
