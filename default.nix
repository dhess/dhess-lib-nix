let

  localLib = import ./lib.nix;
  defaultPkgs = localLib.pkgs;

in

{ pkgs ? defaultPkgs }:

let

  self = localLib.customisation.composeOverlaysFromFiles
           (import ./overlays/overlays-list.nix)
           pkgs;

in
{
  inherit (self) dhallToNixFromFile;
  inherit (self) ffdhe2048Pem ffdhe3072Pem ffdhe4096Pem;
  inherit (self) haskell;
  inherit (self) lib;
  inherit (self) melpaPackagesNgFor melpaPackagesNgFor';

  overlays.all = import ./overlays;
  modules = self.lib.sources.pathDirectory ./modules;
}
