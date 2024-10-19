{
  lib,
  haskellPackages,
  fetchurl,
  callPackage,
  revisions
}:

haskellPackages.mkDerivation {
  pname = "transformers";
  version = revisions.transformers.version;
  src = fetchurl {
    url = "https://hackage.haskell.org/package/transformers-${revisions.transformers.version}/transformers-${revisions.transformers.version}.tar.gz";
    hash = revisions.transformers.hash;
  };
  libraryHaskellDepends = with haskellPackages; [ base ];
  description = "Concrete functor and monad transformers";
  license = lib.licenses.bsd3;
}
