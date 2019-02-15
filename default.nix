let

  defaultPkgs = (import ./lib.nix).pkgs;

in

{ pkgs ? defaultPkgs }:

let

  lib = import ./lib { inherit pkgs; };
  haskell = import ./haskell { inherit pkgs; };

  overlays = {
    lib = lib.importDirectory ./overlays/lib;
    haskell = lib.importDirectory ./overlays/haskell;
    all = import ./overlays;
  };

in
{
  inherit lib;
  inherit haskell;
  inherit overlays;
}
