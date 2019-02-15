let

  defaultPkgs = (import ./lib.nix).pkgs;

in

{ pkgs ? defaultPkgs }:

let

  inherit (pkgs) lib;
  self = lib.foldl'
    (prev: overlay: prev // (overlay (pkgs // self) (pkgs // prev)))
    {} (map import (import ./overlays/overlays-list.nix));

in
{
  inherit (self) lib;
  inherit (self) haskell;
  inherit (self) melpaPackagesNgFor melpaPackagesNgFor';

  overlays.all = import ./overlays;
  modules = self.lib.pathDirectory ./modules;
}
