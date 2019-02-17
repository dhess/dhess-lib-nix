let

  defaultPkgs = (import ./lib.nix).pkgs;

in

{ pkgs ? defaultPkgs }:

let

  inherit (pkgs) lib;
  self =
  let
    overlays = import ./overlays/overlays-list.nix;
    toFix = lib.foldl' (lib.flip lib.extends) (_: pkgs) (map import overlays);
  in
    lib.fix toFix;

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
