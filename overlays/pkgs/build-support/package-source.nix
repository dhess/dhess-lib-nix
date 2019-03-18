{ stdenv
, lib
, name
, version
, srcPath
}:

stdenv.mkDerivation {
  inherit name version;
  src = srcPath;

  installPhase = ''
    mkdir $out
    cp -rp . $out
  '';

  meta.platforms = lib.platforms.all;
}
