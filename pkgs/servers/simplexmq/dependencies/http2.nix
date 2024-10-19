{
  lib,
  haskellPackages,
  fetchFromGitHub,
  callPackage,
  revisions
}:

let
  aeson = callPackage ./aeson.nix { inherit revisions; };
  aeson-pretty = callPackage ./aeson-pretty.nix { inherit revisions; };
in haskellPackages.mkDerivation {
  pname = "http2";
  version = revisions.http2.version;
  src = fetchFromGitHub {
    owner = "kazu-yamamoto";
    repo = "http2";
    rev = revisions.http2.rev;
    hash = revisions.http2.hash;
  };
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = with haskellPackages; [
    array async base bytestring case-insensitive containers http-types
    network network-byte-order psqueues stm time-manager unix-time
    unliftio
  ];
  testHaskellDepends = with haskellPackages; [
    async base base16-bytestring bytestring crypton
    directory filepath Glob hspec http-types network network-byte-order
    network-run random text typed-process unordered-containers vector
  ] ++ [
    aeson aeson-pretty
  ];
  testToolDepends = with haskellPackages; [ hspec-discover ];
  benchmarkHaskellDepends = with haskellPackages; [
    array base bytestring case-insensitive containers gauge
    network-byte-order stm
  ];
  license = lib.licenses.bsd3;
}
