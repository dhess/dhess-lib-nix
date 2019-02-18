let

  localLib = import ./lib;
  defaultPkgs = localLib.pkgs;
  localOverlays = import ./overlays;

in

{ pkgs ? defaultPkgs }:

let

  self = localLib.composeOverlays (localLib.singleton localOverlays) pkgs;

in
{
  inherit (self) dhallToNixFromFile;
  inherit (self) ffdhe2048Pem ffdhe3072Pem ffdhe4096Pem;
  inherit (self) haskell;
  inherit (self) lib;
  inherit (self) melpaPackagesNgFor melpaPackagesNgFor';

  overlays.all = localOverlays;
  modules = self.lib.sources.pathDirectory ./modules;
}
