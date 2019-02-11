self: super:

with super.lib;

(foldl' (flip extends) (_: super)
  (map import (import ./overlays/overlays-list.nix)))
  self
