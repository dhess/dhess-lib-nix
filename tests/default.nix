## An overlay which, when loaded, defines some self-testing packages.
## All you need to do is build these packages, and the tests will run
## in each package's checkPhase.

self: super:

let

  inherit (super) callPackage;
  inherit (self) lib;

in
{

  ## cleanSourceX tests.

  dlnCleanSourceNix = callPackage ./cleanNix { src = lib.cleanSourceNix ./test-dir; };
  dlnCleanSourceHaskell = callPackage ./cleanHaskell { src = lib.cleanSourceHaskell ./test-dir; };
  dlnCleanSourceSystemCruft = callPackage ./cleanSystemCruft { src = lib.cleanSourceSystemCruft ./test-dir; };
  dlnCleanSourceEditors = callPackage ./cleanEditors { src = lib.cleanSourceEditors ./test-dir; };
  dlnCleanSourceMaintainer = callPackage ./cleanMaintainer { src = lib.cleanSourceMaintainer ./test-dir; };
  dlnCleanSourceAllExtraneous = callPackage ./cleanAllExtraneous { src = lib.cleanSourceAllExtraneous ./test-dir; };


  ## cleanPackage tests.

  dlnCleanPackageNix = lib.cleanPackage lib.cleanSourceNix (callPackage ./cleanNix { src = ./test-dir;});
  dlnCleanPackageHaskell = lib.cleanPackage lib.cleanSourceHaskell (callPackage ./cleanHaskell { src = ./test-dir;});
  dlnCleanPackageSystemCruft = lib.cleanPackage lib.cleanSourceSystemCruft (callPackage ./cleanSystemCruft { src = ./test-dir;});
  dlnCleanPackageEditors = lib.cleanPackage lib.cleanSourceEditors (callPackage ./cleanEditors { src = ./test-dir;});
  dlnCleanPackageMaintainer = lib.cleanPackage lib.cleanSourceMaintainer (callPackage ./cleanMaintainer { src = ./test-dir;});
  dlnCleanPackageAllExtraneous = lib.cleanPackage lib.cleanSourceAllExtraneous (callPackage ./cleanAllExtraneous { src = ./test-dir;});


  ## attrsets tests.

  dlnAttrSets = callPackage ./attrsets {};


  ## IP address utility tests.

  dlnIPAddr = callPackage ./ipaddr {};


  ## Miscellaneous tests.

  dlnMisc = callPackage ./misc {};


  ## Types tests.

  dlnTypes = callPackage ./types {};


  ## Security tests.

  dlnFfdhe = callPackage ./security/ffdhe {};
}
