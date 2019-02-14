self: super:

let

  overlay = {
    lib = (import ../../haskell/lib) { pkgs = super; };
  };

in
{
  haskell = (super.haskell or {}) // {
    lib = (super.haskell.lib or {}) // overlay.lib;
  };
}
