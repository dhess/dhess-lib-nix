self: super:

let

  dhallToNixFromFile = fileName:
  let
    source = builtins.readFile fileName;
  in
    super.dhallToNix source;

in
{
  inherit dhallToNixFromFile;
}
