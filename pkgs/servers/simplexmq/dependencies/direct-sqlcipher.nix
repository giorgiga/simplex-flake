{
  lib,
  haskellPackages,
  fetchFromGitHub,
  callPackage,
  revisions
}:

haskellPackages.mkDerivation {
  pname = "direct-sqlcipher";
  version = revisions.direct-sqlcipher.version;
  src = fetchFromGitHub {
    owner = "simplex-chat";
    repo = "direct-sqlcipher";
    rev = revisions.direct-sqlcipher.rev;
    hash = revisions.direct-sqlcipher.hash;
  };
  libraryHaskellDepends = with haskellPackages; [ base bytestring text ];
  testHaskellDepends = with haskellPackages; [
    base base16-bytestring bytestring directory HUnit temporary text
  ];
  license = lib.licenses.bsd3;
}
