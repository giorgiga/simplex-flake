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
  pname = "network-transport";
  version = revisions.network-transport.version;
  src = fetchurl {
    url = "https://hackage.haskell.org/package/network-transport-${revisions.network-transport.version}/network-transport-${revisions.network-transport.version}.tar.gz";
    hash = revisions.network-transport.hash;
  };
  libraryHaskellDepends = with haskellPackages; [
    base binary bytestring deepseq hashable
  ] ++ [ transformers ];
  homepage = "http://haskell-distributed.github.com";
  description = "Network abstraction layer";
  license = lib.licenses.bsd3;
}
