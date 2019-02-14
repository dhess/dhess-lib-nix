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

  pkgs = pkgs.recurseIntoAttrs (pkgs.lib.makeScope pkgs.newScope (self: with self; {
    lib = pkgs.lib // toplevel.lib;
    haskell = callPackage ./haskell {};
  }));

};

in
toplevel
