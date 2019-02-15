let

  defaultPkgs = (import ./lib.nix).pkgs;

in

{ pkgs ? defaultPkgs }:

let

  lib = import ./lib { inherit pkgs; };

in
{
  inherit lib;
}
