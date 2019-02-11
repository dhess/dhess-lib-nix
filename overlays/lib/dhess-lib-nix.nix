self: super:

let
  # Provide access to the whole package, if needed.
  path = ../../.;

in
{
  lib = (super.lib or {}) // {
    dhess-lib-nix = (super.lib.dhess-lib-nix or {}) // {
      inherit path;
    };
  };
}
