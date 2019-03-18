self: super:

let

  dhess-lib-nix-source = super.packageSource "dhess-lib-nix-source" "1.0" ../../..;

in
{
  inherit dhess-lib-nix-source;
}
