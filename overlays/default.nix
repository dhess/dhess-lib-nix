self: super:

with super.lib;

let

  overlays = [
    ./lib
    ./haskell
  ];

in
(foldl' (flip extends) (_: super)
  (map import overlays))
  self
