{
  lib,
  haskellPackages,
  fetchFromGitHub,
  callPackage,
  revisions
}:
let
  aeson = callPackage ./aeson.nix { inherit revisions; };
in haskellPackages.mkDerivation rec {
  pname = "attoparsec-aeson";
  version = revisions.aeson.version;
  # src = "${aeson-src}/attoparsec-aeson";
  # src = stdenv.mkDerivation {
  #   dontUnpack = true;
  #   installPhase = ''
  #     runHook preInstall
  #     cp -rL attoparsec-aeon/* $out
  #     runHook postInstall
  #   '';
  # };
  src = fetchFromGitHub {
    owner = "simplex-chat";
    repo = "aeson";
    rev = revisions.aeson.rev;
    hash = revisions.aeson.hash;
  };
  postUnpack = ''
  echo XXXXXXXXXXXXXXXXXXXXXXXXXXX
  echo ${src}
  pwd
  ls -l
  export sourceRoot=attoparsec-aeon
  cd attoparsec-aeon
  echo XXXXXXXXXXXXXXXXXXXXXXXXXXX
  '';
  libraryHaskellDepends = with haskellPackages; [
    attoparsec base bytestring integer-conversion primitive
    scientific text vector
    # XXX the one in nixpkackages only depends on [ base aeson ]?
  ] ++ [ aeson ];
  license = lib.licenses.bsd3;
}
