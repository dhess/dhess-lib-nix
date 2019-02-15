self: super:

with super.lib;

(foldl' (flip extends) (_: super)
  (map import (import ./overlays-list.nix)))
  self
