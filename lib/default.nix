let

  defaultPkgs = (import ../lib.nix).pkgs;

in

{ pkgs ? defaultPkgs }:

let

  callLibs = path: import path { inherit pkgs; };

  ## Namespaced.

  attrsets = callLibs ./attrsets;
  dhall = callLibs ./dhall;
  dhess-lib-nix = callLibs ./dhess-lib-nix;
  dns = callLibs ./dns;
  emacs = callLibs ./emacs;
  ipaddr = callLibs ./ipaddr;
  maintainers = callLibs ./maintainers;
  security = callLibs ./security;
  testing = callLibs ./testing;
  types = callLibs ./types;


  ## Top-level.

  cleanSource = callLibs ./clean-source.nix;
  directory = callLibs ./directory.nix;
  operators = callLibs ./operators.nix;
  secrets = callLibs ./secrets.nix;

  lib = {
    inherit attrsets;
    inherit dhall;
    inherit dhess-lib-nix;
    inherit dns;
    inherit emacs;
    inherit ipaddr;
    inherit maintainers;
    inherit security;
    inherit testing;
    inherit types;
  }
  // cleanSource
  // directory
  // operators
  // secrets
  ;

in
lib
