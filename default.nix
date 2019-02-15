let

  defaultPkgs = (import ./lib.nix).pkgs;

in

{ pkgs ? defaultPkgs }:

let

  lib     = import ./lib { inherit pkgs; };
  haskell = import ./haskell { inherit pkgs; };

  overlays.lib     = import ./overlays/lib;
  overlays.haskell = import ./overlays/haskell;
  overlays.all     = import ./overlays;

in
{
  inherit lib;
  inherit haskell;
  inherit overlays;
}
