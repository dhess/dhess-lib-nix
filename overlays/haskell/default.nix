self: super:

let

  selfHaskell = (import ../../haskell) { pkgs = super; };

in
{
  haskell = (super.haskell or {}) // selfHaskell;
}
