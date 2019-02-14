{ pkgs }:

let

  # Make an extensible closure of packages.
  makePackageSet = f: pkgs.recurseIntoAttrs (pkgs.lib.makeScope pkgs.newScope f);

in
{
  inherit makePackageSet;
}
