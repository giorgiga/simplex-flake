{
  lib,
  haskellPackages,
  fetchFromGitHub,
  callPackage,
  revisions
}:

haskellPackages.mkDerivation {
  pname = "socks";
  version = revisions.socks.version;
  src = fetchFromGitHub {
    owner = "simplex-chat";
    repo = "hs-socks";
    rev = revisions.socks.rev;
    hash = revisions.socks.hash;
  };
  libraryHaskellDepends = with haskellPackages; [
    base basement bytestring cereal network
  ];
  license = lib.licenses.bsd3;
}
