{
  lib,
  haskellPackages,
  fetchurl,
  callPackage,
  revisions
}:

let
  transformers = callPackage ./transformers.nix { inherit revisions; };
in haskellPackages.mkDerivation {
  pname = "exceptions";
  version = revisions.exceptions.version;
  src = fetchurl {
    url = "https://hackage.haskell.org/package/exceptions-${revisions.exceptions.version}/exceptions-${revisions.exceptions.version}.tar.gz";
    hash = revisions.exceptions.hash;
  };
  libraryHaskellDepends = with haskellPackages; [
    base binary bytestring deepseq hashable
  ] ++ [ transformers ];
  license = lib.licenses.bsd3;
}
