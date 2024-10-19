{
  lib,
  haskellPackages,
  fetchFromGitHub,
  callPackage,
  revisions
}:

let
  direct-sqlcipher = callPackage ./direct-sqlcipher.nix { inherit revisions; };
in haskellPackages.mkDerivation {
    pname = "sqlcipher-simple";
    version = revisions.sqlcipher-simple.version;
    src = fetchFromGitHub {
    owner = "simplex-chat";
    repo = "sqlcipher-simple";
    rev = revisions.sqlcipher-simple.rev;
    hash = revisions.sqlcipher-simple.hash;
    };
    doCheck = false; # one test fails
    libraryHaskellDepends = (with haskellPackages; [
    attoparsec base blaze-builder blaze-textual bytestring containers
    exceptions Only template-haskell text time
    transformers
    ]) ++ [ direct-sqlcipher ];
    testHaskellDepends = (with haskellPackages; [
    base base16-bytestring bytestring HUnit text time
    ]) ++ [ direct-sqlcipher ];
    license = lib.licenses.bsd3;
}
