self: super:

let

  operators = (import ../../lib/operators.nix) { pkgs = super; };

in
{
  lib = (super.lib or {}) // operators;
}
