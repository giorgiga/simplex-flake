{
  lib,
  haskellPackages,
  fetchFromGitHub,
  revisions
}:

haskellPackages.mkDerivation {
  pname = "aeson";
  version = revisions.aeson.version;
  src = fetchFromGitHub {
    owner = "simplex-chat";
    repo = "aeson";
    rev = revisions.aeson.rev;
    hash = revisions.aeson.hash;
  };
  libraryHaskellDepends = with haskellPackages; [
    base bytestring containers data-fix deepseq dlist exceptions
    generically ghc-prim hashable indexed-traversable
    integer-conversion integer-logarithms network-uri OneTuple
    primitive QuickCheck scientific semialign strict tagged
    template-haskell text text-iso8601 text-short th-abstraction these
    time time-compat unordered-containers uuid-types vector witherable
  ];
  testHaskellDepends = with haskellPackages; [
    base base-compat base-orphans base16-bytestring bytestring
    containers data-fix deepseq Diff directory dlist filepath
    generic-deriving generically ghc-prim hashable indexed-traversable
    integer-logarithms network-uri nothunks OneTuple primitive
    QuickCheck quickcheck-instances scientific strict tagged tasty
    tasty-golden tasty-hunit tasty-quickcheck template-haskell text
    text-short these time time-compat unordered-containers uuid-types
    vector
  ];
  license = lib.licenses.bsd3;
}
