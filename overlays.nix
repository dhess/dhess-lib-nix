## Return a Nixpkgs augmented with the local overlays.

let

  overlays = [ (import ./overlays) ];
  pkgsWithOverlays =  (import ./lib.nix).nixpkgs { inherit overlays; };

in
pkgsWithOverlays
