let

  defaultPkgs = (import ./lib.nix).pkgs;

in

{ pkgs ? defaultPkgs }:

let

  attrsets = pkgs.callPackage lib/attrsets {};

in
{
  lib = {
    inherit attrsets;
  };
}
