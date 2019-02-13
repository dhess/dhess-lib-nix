{ ... }:

let

  exclusiveOr = x: y: (x && !y) || (!x && y);

in
{
  inherit exclusiveOr;
}
