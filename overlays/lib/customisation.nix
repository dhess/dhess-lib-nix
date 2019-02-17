self: super:

let

  ## These functions are useful for building package sets from
  ## stand-alone overlay repos.

  composeOverlays = overlays: pkgs:
  let
    toFix = super.lib.foldl'
              (super.lib.flip super.lib.extends)
              (super.lib.const pkgs)
              overlays;
  in
    super.lib.fix toFix;

  composeOverlaysFromFiles = overlaysFiles: pkgs:
    composeOverlays (map import overlaysFiles) pkgs;

in
{
  lib = (super.lib or {}) // {
    customisation = (super.lib.customisation or {}) // {
      inherit composeOverlays composeOverlaysFromFiles;
    };
  };
}
