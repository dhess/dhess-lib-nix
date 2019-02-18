self: super:

let

  localLib = import ../lib;

in
localLib.composeOverlaysFromFiles (import ./overlays-list.nix) super
