{ pkgs }:

let

  # Given an emacs and local emacs packages overrides, generate an
  # "Ng" package set for it, but override the standard Nixpkgs emacs
  # package locations with Melpa versions.
  #
  # Adapted from:
  # https://github.com/jwiegley/nix-config/blob/d22b72f14510d07e1438907e87cf26b34390a25f/overlays/10-emacs.nix#L929
  melpaPackagesNgFor' = emacs: epkgsOverrides:
    (pkgs.emacsPackagesNgFor emacs).overrideScope' (_: super:
      pkgs.lib.fix
        (pkgs.lib.extends
           epkgsOverrides
           (_: super.melpaPackages
                 // { inherit emacs;
                      inherit (super) melpaBuild;
                    })));

  # Given an emacs, generate an "Ng" package set for it, but override
  # the standard Nixpkgs emacs package locations with Melpa versions.
  melpaPackagesNgFor = emacs: melpaPackagesNgFor' emacs (_: _: {});

in

{
  inherit melpaPackagesNgFor melpaPackagesNgFor';
}
