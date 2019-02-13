## Convenience functions for tests, esp. for Hydras.

{ ... }:

let

  enumerateSystems = pkg: systems: map (system: pkg.${system}) systems;

in
{
  inherit enumerateSystems;
}
