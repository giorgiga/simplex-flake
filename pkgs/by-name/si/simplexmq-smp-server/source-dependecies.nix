{ lib
, haskellPackages
, fetchFromGitHub
, pkgs
}: revisions:
let

  aeson-src = fetchFromGitHub {
    owner = "simplex-chat";
    repo = "aeson";
    rev = revisions.aeson.rev;
    hash = revisions.aeson.hash;
  };

in let

  aeson = haskellPackages.mkDerivation {
    pname = "aeson";
    version = revisions.aeson.version;
    src = aeson-src;
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
    # homepage = "https://github.com/simplex-chat/aeson";
    # description = "Simplex-chat fork of https://github.com/haskell/aeson";
    license = lib.licenses.bsd3;
  };

in let

  attoparsec-aeson = haskellPackages.mkDerivation {
    pname = "attoparsec-aeson";
    version = revisions.aeson.version;
    src = aeson-src;
    sourceRoot = "${aeson-src}/attoparsec-aeson";
    libraryHaskellDepends = with haskellPackages; [
      attoparsec base bytestring integer-conversion primitive
      scientific text vector
      # XXX the one in nixpkackages only depends on [ base aeson ]?
    ] ++ [ aeson ];
    # homepage = "https://github.com/haskell/aeson";
    # description = "Parsing of aeson's Value with attoparsec";
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
    # homepage = "http://github.com/informatikr/aeson-pretty";
    # description = "JSON pretty-printing library and command-line tool";
    license = lib.licenses.bsd3;
    mainProgram = "aeson-pretty";
  };

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
      #homepage = "https://github.com/UnkindPartition/ansi-terminal";
      #description = "Types and functions used to represent SGR aspects";
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
    #homepage = "https://github.com/UnkindPartition/ansi-terminal";
    #description = "Simple ANSI terminal support, with Windows compatibility";
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
    # homepage = "http://github.com/ekmett/constraints/";
    # description = "Constraint manipulation";
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
    # homepage = "https://github.com/kazu-yamamoto/http2";
    # description = "HTTP/2 library";
    license = lib.licenses.bsd3;
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
    # homepage = "https://github.com/simplex-chat/direct-sqlcipher";
    # description = "Low-level binding to SQLCipher. Includes UTF8 and BLOB support.";
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
    # homepage = "https://github.com/simplex-chat/sqlcipher-simple";
    # description = "Mid-Level SQLite client library";
    license = lib.licenses.bsd3;
  };

in {

  inherit aeson direct-sqlcipher sqlcipher-simple
          ansi-terminal constraints http2
          # aeson-pretty
          ;

  simplexmq = haskellPackages.mkDerivation {
    pname = "simplexmq";
    version = revisions.simplexmq.version;
    src = fetchFromGitHub {
      owner = "simplex-chat";
      repo = "simplexmq";
      rev = revisions.simplexmq.rev;
      hash = revisions.simplexmq.hash;
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
    ]) ++ [
      aeson direct-sqlcipher sqlcipher-simple
      ansi-terminal constraints http2
    ];
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
    ]) ++ [
      aeson direct-sqlcipher sqlcipher-simple
      ansi-terminal constraints http2
    ];
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
    ]) ++ [
      aeson direct-sqlcipher sqlcipher-simple
      ansi-terminal constraints http2
    ];
    # homepage = "https://github.com/simplex-chat/simplexmq#readme";
    # description = "SimpleXMQ message broker";
    license = lib.licenses.agpl3Only;
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
    # homepage = "http://github.com/vincenthz/hs-socks";
    # description = "Socks proxy (ver 5)";
    license = lib.licenses.bsd3;
  };

  terminal = haskellPackages.mkDerivation {
    pname = "terminal";
    version = revisions.terminal.version;
    src = fetchFromGitHub {
      owner = "simplex-chat";
      repo = "haskell-terminal";
      rev = revisions.terminal.rev;
      hash = revisions.terminal.hash;
    };
    libraryHaskellDepends = with haskellPackages; [
      async base bytestring exceptions prettyprinter stm text
      transformers
    ];
    testHaskellDepends = with haskellPackages; [
      async base bytestring exceptions prettyprinter stm tasty
      tasty-hunit tasty-quickcheck text transformers
    ];
    # homepage = "https://github.com/lpeterse/haskell-terminal#readme";
    # description = "Portable terminal interaction library";
    license = lib.licenses.bsd3;
  };

  android-support = haskellPackages.mkDerivation {
    pname = "android-support";
    version = revisions.android-support.version;
    src = fetchFromGitHub {
      owner = "simplex-chat";
      repo = "android-support";
      rev = revisions.android-support.rev;
      hash = revisions.android-support.hash;
    };
    libraryHaskellDepends = with haskellPackages; [ base ];
    license = "unknown";
  };

  zip = haskellPackages.mkDerivation {
    pname = "zip";
    version = revisions.zip.version;
    src = fetchFromGitHub {
      owner = "simplex-chat";
      repo = "zip";
      rev = revisions.zip.rev;
      hash = revisions.zip.hash;
    };
    isLibrary = true;
    isExecutable = true;
    libraryHaskellDepends = with haskellPackages; [
      base bytestring bzlib-conduit case-insensitive cereal conduit
      conduit-extra conduit-zstd containers digest directory dlist
      exceptions filepath monad-control mtl resourcet text time
      transformers transformers-base unix
    ];
    executableHaskellDepends = with haskellPackages; [ base filepath ];
    testHaskellDepends = with haskellPackages; [
      base bytestring conduit containers directory dlist exceptions
      filepath hspec QuickCheck temporary text time transformers
    ];
    # homepage = "https://github.com/mrkkrp/zip";
    # description = "Operations on zip archives";
    license = lib.licenses.bsd3;
    mainProgram = "haskell-zip-app";
  };

}
