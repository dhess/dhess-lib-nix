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
  inherit (self) dhallToNixFromFile;
  inherit (self) ffdhe2048Pem ffdhe3072Pem ffdhe4096Pem;
  inherit (self) haskell;
  inherit (self) lib;
  inherit (self) melpaPackagesNgFor melpaPackagesNgFor';

  overlays.all = import ./overlays;
  modules = self.lib.pathDirectory ./modules;
}
