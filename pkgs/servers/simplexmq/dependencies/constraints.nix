{
  lib,
  haskellPackages,
  fetchFromGitHub,
  callPackage,
  revisions
}:

haskellPackages.mkDerivation {
  pname = "constraints";
  version = revisions.constraints.version;
  src = fetchFromGitHub {
    owner = "ekmett";
    repo = "constraints";
    rev = revisions.constraints.rev;
    hash = revisions.constraints.hash;
  };
  libraryHaskellDepends = with haskellPackages; [
    base binary deepseq ghc-prim hashable mtl transformers
    transformers-compat type-equality
  ];
  testHaskellDepends = with haskellPackages; [ base hspec ];
  testToolDepends = with haskellPackages; [ hspec-discover ];
  license = lib.licenses.bsd2;
}
