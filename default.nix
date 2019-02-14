let

  defaultPkgs = (import ./lib.nix).pkgs;

in

{ pkgs ? defaultPkgs }:

let toplevel = {

  lib     = import ./lib { inherit pkgs; };

  overlays.lib     = import ./overlays/lib;
  overlays.haskell = import ./overlays/haskell;
  overlays.all     = import ./overlays;

  modules = import ./modules;

  pkgs = toplevel.lib.customisation.makePackageSet (pkgs.lib.const {
    inherit (toplevel) lib;
    haskell = import ./haskell { inherit pkgs; };
  });

};

in
toplevel
