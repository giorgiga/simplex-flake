{ lib
, stdenv
, haskellPackages
, fetchFromGitHub
, pkgs, callPackage, revisions

} @args:
let
  revisions = import ./revisions.nix;
  simplexDependencies = lib.listToAttrs (map (name: {
    inherit name;
    value = callPackage (./dependencies + "/${name}.nix") { inherit revisions; };
  }) [
    # ls pkgs/servers/simplexmq/dependencies/ | sed -E 's:(.*)\.nix:"\1":'
    "aeson"
    "aeson-pretty"
    "ansi-terminal"
    "attoparsec-aeson"
    "constraints"
    "direct-sqlcipher"
    "http2"
    "ini"
    "network-transport"
    "socks"
    "sqlcipher-simple"
    "transformers"
  ]);
in
haskellPackages.mkDerivation {
  pname = "simplexmq-smp-server";
  version = "6.0.6";

  src = fetchFromGitHub {
    owner = "simplex-chat";
    repo = "simplexmq";
    rev = "v6.0.6";
    hash = "sha256-ZNSPIDWyBsf7FeOU+5vwlkcJiS9hMpfyOfDNfwjn8Bs=";
  };

  isLibrary = true;
  isExecutable = true;

  libraryHaskellDepends = (with haskellPackages; [
    asn1-encoding asn1-types async attoparsec base
    base64-bytestring bytestring case-insensitive composition
    containers crypton crypton-x509 crypton-x509-store
    crypton-x509-validation cryptostore data-default
    directory filepath hashable hourglass http-types iproute
    iso8601-time memory mtl network network-info
    network-udp optparse-applicative process random simple-logger socks
    stm template-haskell temporary text time
    time-manager tls unliftio unliftio-core websockets
    yaml zstd
  ]) ++ (with simplexDependencies; [
    aeson direct-sqlcipher sqlcipher-simple
    ansi-terminal constraints http2 ini transformers network-transport
  ]);

  librarySystemDepends = with pkgs; [ openssl ];
  executableHaskellDepends = (with haskellPackages; [
    asn1-encoding asn1-types async attoparsec base
    base64-bytestring bytestring case-insensitive composition
      containers crypton crypton-x509 crypton-x509-store
    crypton-x509-validation cryptostore data-default
    directory file-embed filepath hashable hourglass http-types
    iproute iso8601-time memory mtl network network-info
     network-udp optparse-applicative process random
    simple-logger socks stm template-haskell temporary
    text time time-manager tls unliftio unliftio-core
    wai-app-static warp warp-tls websockets yaml zstd
  ]) ++ (with simplexDependencies; [
    aeson direct-sqlcipher sqlcipher-simple
    ansi-terminal constraints http2 ini transformers network-transport
  ]);

  testHaskellDepends = (with haskellPackages; [
    asn1-encoding asn1-types async attoparsec base
    base64-bytestring bytestring case-insensitive composition
    containers crypton crypton-x509 crypton-x509-store
    crypton-x509-validation cryptostore data-default deepseq
    directory filepath generic-random hashable
    hourglass hspec hspec-core http-types HUnit iproute
    iso8601-time main-tester memory mtl network network-info
     network-udp optparse-applicative process
    QuickCheck random silently simple-logger socks stm
    template-haskell temporary text time time-manager timeit tls
    unliftio unliftio-core websockets yaml zstd
  ]) ++ (with simplexDependencies; [
    aeson direct-sqlcipher sqlcipher-simple
    ansi-terminal constraints http2 ini transformers network-transport
  ]);

  homepage = "https://github.com/simplex-chat/simplexmq#readme";
  description = "SimpleXMQ message broker";
  license = lib.licenses.agpl3Only;
  mainProgram = "smp-server";
  platforms = [ "x86_64-linux" ];
  maintainers = with lib.maintainers; [ giorgiga ];

}

# Error: Setup: Encountered missing or private dependencies:
# ini ==0.4.1,
# network-transport ==0.5.6,
# optparse-applicative >=0.15 && <0.17,
# tls >=1.9.0 && <1.10
