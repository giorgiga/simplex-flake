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
  version = revisions.attoparsec-aeson.version;
  src = fetchFromGitHub {
    owner = "simplex-chat";
    repo = "aeson";
    rev = revisions.attoparsec-aeson.rev;
    hash = revisions.attoparsec-aeson.hash;
  };
  postUnpack = ''
    mv source source-aeson
    cp -rL source-aeson/attoparsec-aeson source
    rm -fr source-aeson
  '';
  libraryHaskellDepends = (with haskellPackages; [ attoparsec base ])
                       ++ [ aeson ];
  license = lib.licenses.bsd3;
}
