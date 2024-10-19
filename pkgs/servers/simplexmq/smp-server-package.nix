{ lib
, stdenv
, haskellPackages
, fetchFromGitHub
, pkgs, callPackage, revisions

} @args:
let
  revisions = import ./revisions.nix;
  sourceDependencies =
  let

    aeson-src = fetchFromGitHub {
      owner = "simplex-chat";
      repo = "aeson";
      rev = revisions.aeson.rev;
      hash = revisions.aeson.hash;
    };

    direct-sqlcipher = haskellPackages.mkDerivation {
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
    };

  in let

    aeson = callPackage ./aeson.nix { inherit revisions; };

  in let

    attoparsec-aeson = haskellPackages.mkDerivation {
      pname = "attoparsec-aeson";
      version = revisions.aeson.version;
      # src = "${aeson-src}/attoparsec-aeson";
      # src = stdenv.mkDerivation {
      #   dontUnpack = true;
      #   installPhase = ''
      #     runHook preInstall
      #     cp -rL attoparsec-aeon/* $out
      #     runHook postInstall
      #   '';
      # };
      src = aeson-src;
      postUnpack = ''
      echo XXXXXXXXXXXXXXXXXXXXXXXXXXX
      echo ${aeson-src}
      pwd
      ls -l
      export sourceRoot=attoparsec-aeon
      cd attoparsec-aeon
      echo XXXXXXXXXXXXXXXXXXXXXXXXXXX
      '';
      libraryHaskellDepends = with haskellPackages; [
        attoparsec base bytestring integer-conversion primitive
        scientific text vector
        # XXX the one in nixpkackages only depends on [ base aeson ]?
      ] ++ [ aeson ];
      license = lib.licenses.bsd3;
    };

  in let

    aeson-pretty = haskellPackages.mkDerivation {
      pname = "aeson-pretty";
      version = revisions.aeson-pretty.version;
      src = fetchFromGitHub {
        owner = "informatikr";
        repo = "aeson-pretty";
        rev = revisions.aeson-pretty.rev;
        hash = revisions.aeson-pretty.hash;
      };
      isLibrary = true;
      isExecutable = true;
      libraryHaskellDepends = with haskellPackages; [
        base base-compat bytestring scientific text
        unordered-containers vector
      ] ++ [ aeson ];
      executableHaskellDepends = with haskellPackages; [
        attoparsec base bytestring cmdargs
      ] ++ [ aeson attoparsec-aeson ];
      license = lib.licenses.bsd3;
      mainProgram = "aeson-pretty";
    };

  in {

    inherit aeson aeson-pretty attoparsec-aeson direct-sqlcipher;

    ansi-terminal =
    let
      ansi-terminal-src = fetchFromGitHub {
        owner = "UnkindPartition";
        repo = "ansi-terminal";
        rev = revisions.ansi-terminal.rev;
        hash = revisions.ansi-terminal.hash;
      };
      ansi-terminal-types = haskellPackages.mkDerivation {
        pname = "ansi-terminal-types";
        version = revisions.ansi-terminal.version;
        src = "${ansi-terminal-src}/ansi-terminal-types";
        libraryHaskellDepends = with haskellPackages; [ base colour ];
        license = lib.licenses.bsd3;
      };
    in haskellPackages.mkDerivation {
      pname = "ansi-terminal";
      version = revisions.ansi-terminal.version;
      src = "${ansi-terminal-src}/ansi-terminal";
      isLibrary = true;
      isExecutable = true;
      libraryHaskellDepends = (with haskellPackages; [ base colour ])
                          ++ [ ansi-terminal-types ];
      license = lib.licenses.bsd3;
    };

    constraints = haskellPackages.mkDerivation {
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
    };

    http2 = haskellPackages.mkDerivation {
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
    };

    socks = haskellPackages.mkDerivation {
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
    };

    sqlcipher-simple = haskellPackages.mkDerivation {
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
    };

  };
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
    directory filepath hashable hourglass http-types  ini iproute
    iso8601-time memory mtl network network-info network-transport
    network-udp optparse-applicative process random simple-logger socks
    stm template-haskell temporary text time
    time-manager tls transformers unliftio unliftio-core websockets
    yaml zstd
  ]) ++ (with sourceDependencies; [
    aeson direct-sqlcipher sqlcipher-simple
    ansi-terminal constraints http2
  ]);

  librarySystemDepends = with pkgs; [ openssl ];
  executableHaskellDepends = (with haskellPackages; [
    asn1-encoding asn1-types async attoparsec base
    base64-bytestring bytestring case-insensitive composition
      containers crypton crypton-x509 crypton-x509-store
    crypton-x509-validation cryptostore data-default
    directory file-embed filepath hashable hourglass http-types
    ini iproute iso8601-time memory mtl network network-info
    network-transport network-udp optparse-applicative process random
    simple-logger socks stm template-haskell temporary
    text time time-manager tls transformers unliftio unliftio-core
    wai-app-static warp warp-tls websockets yaml zstd
  ]) ++ (with sourceDependencies; [
    aeson direct-sqlcipher sqlcipher-simple
    ansi-terminal constraints http2
  ]);

  testHaskellDepends = (with haskellPackages; [
    asn1-encoding asn1-types async attoparsec base
    base64-bytestring bytestring case-insensitive composition
    containers crypton crypton-x509 crypton-x509-store
    crypton-x509-validation cryptostore data-default deepseq
    directory filepath generic-random hashable
    hourglass hspec hspec-core http-types HUnit ini iproute
    iso8601-time main-tester memory mtl network network-info
    network-transport network-udp optparse-applicative process
    QuickCheck random silently simple-logger socks stm
    template-haskell temporary text time time-manager timeit tls
    transformers unliftio unliftio-core websockets yaml zstd
  ]) ++ (with sourceDependencies; [
    aeson direct-sqlcipher sqlcipher-simple
    ansi-terminal constraints http2
  ]);

  homepage = "https://github.com/simplex-chat/simplexmq#readme";
  description = "SimpleXMQ message broker";
  license = lib.licenses.agpl3Only;
  mainProgram = "smp-server";
  platforms = [ "x86_64-linux" ];
  maintainers = with lib.maintainers; [ giorgiga ];

}
