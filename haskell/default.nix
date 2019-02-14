let

  defaultPkgs = (import ../lib.nix).pkgs;

in

{ pkgs ? defaultPkgs }:

let

  callLibs = path: import path { inherit pkgs; };

  ## Namespaced.

  lib = callLibs ./lib;

  haskell = {
    inherit lib;
  };

in
haskell
