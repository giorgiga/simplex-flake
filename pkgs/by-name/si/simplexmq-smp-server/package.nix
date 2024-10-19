{ lib
, haskellPackages
, fetchFromGitHub
, pkgs
} @args:
let
  sourceDependencies = (import ./source-dependecies.nix) args {
    # These are dependencies declared as source dependencies in
    # cabal.project (from the simplex-chat sources).
    # The values for "rev" are from cabal.project in simplex-chat sources,
    # hashes and versions need to be determined every time :(
#    simplexmq = {
#      rev = "4268b90763c58358809a3ea7dd8bc7d78eeb3077";
#      version = "6.0.5.0";
#      hash = "sha256-ZYrovC7Od56hCOFrQxYm71rnKo+2l+FufLDE3pckhHA=";
#    };
    socks = {
      rev = "a30cc7a79a08d8108316094f8f2f82a0c5e1ac51";
      version = "0.6.1";
      hash = "sha256-aEgouR5om+yElV5efcsLi+4plvq7qimrOTOkd7LdWnk=";
    };
    direct-sqlcipher = {
      rev = "f814ee68b16a9447fbb467ccc8f29bdd3546bfd9";
      version = "2.3.28";
      hash = "sha256-9/K1pnUnUTLj6OV5neQF6bDrQvtgi0a4VekJQuuGPE4=";
    };
    sqlcipher-simple = {
      rev = "a46bd361a19376c5211f1058908fc0ae6bf42446";
      version = "0.4.18.1";
      hash = "sha256-9JV2odagCkUWUGEe8dWmqHfjcBmn6rf6FAEBhxo6Gfw=";
    };
    aeson = {
      rev = "aab7b5a14d6c5ea64c64dcaee418de1bb00dcc2b";
      version = "2.2.1.0";
      hash = "sha256-OTuJENv5I+9bWy6crllDm1lhkncmye33SCiqh1Sb50s=";
    };
#    terminal = {
#      rev = "f708b00009b54890172068f168bf98508ffcd495";
#      version = "0.2.0.0";
#      hash = "sha256-UsYatiz9pqdH+kY5RSxC8ajlh0nlHfIAGRVN7So9uH4=";
#    };
#    android-support = { # XXX is this actually used?
#      rev = "9aa09f148089d6752ce563b14c2df1895718d806";
#      version = "0.1.0.0";
#      hash = "";
#    };
#    zip = {
#      rev = "bd421c6b19cc4c465cd7af1f6f26169fb8ee1ebc";
#      version = "2.0.0";
#      hash = "sha256-4D2jCnG26h8zDMgK59KKZB0ezarN9j4JLIsjtqF0WLM=";
#    };
    # These are depencencies that in simplex-chat.cabal (again, from the
    # simplex-chat sources) are incompatible (older) than those in nixpkgs.
#    ansi-terminal = rec {
#      rev = "v${version}";
#      version = "0.11.5";
#      hash = "sha256-fOFwGLwrpH5W6K0/yaNsbxb9N02fFIiZNotbeu+6z5I=";
#    };
#    constraints = rec {
#      rev = "v${version}";
#      version = "0.13.4";
#      hash = "sha256-jQRsNW2LsABx1L9Fnaalomb21jYzev9ODfxj+Za+RlU=";
#    };
#    http2 = rec {
#      rev = "v${version}";
#      version = "4.2.2";
#      hash = "sha256-ZiG0vBtm8FZW1Lpe6zJnBMkzfq0iiEtjShXudwgA3Ts=";
#    };
    # This is a dependency of http2 that we can't get from nixpkgs because that
    # it depends on aeson and the aeson in nixpkgs is older than the one needed
    # for simplex-chat.
    # The cabal error/warning is:
    # > This package indirectly depends on multiple versions of the same package. This is very likely to cause a compile failure.
    # >   package aeson-pretty (aeson-pretty-0.8.10-vw03QN2por7ZYxwQQUvoy) requires aeson-2.1.2.1-5WdrEEVuAsP6QTsCQjWYxr
    # >   package http2 (http2-4.2.2) requires aeson-2.2.1.0-D7zriyh5se48Xb20atT7oD
    # >   package http2 (http2-4.2.2) requires aeson-2.2.1.0-D7zriyh5se48Xb20atT7oD
#    aeson-pretty = rec {
#      # using the commit hash since version 0.8.10 is not tagged
#      # see https://github.com/informatikr/aeson-pretty/issues/48
#      rev = "fcc4e96baf7deca8437d75108a56862e9bf40751";
#      version = "0.8.10";
#      hash = "sha256-qokNKZIQM4DNSX8aVd9VZJ9HuL7FqbklIlYgSR5CB/Y=";
#    };
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
    async attoparsec base base64-bytestring
    bytestring composition containers crypton data-default
    directory email-validate exceptions filepath
    http-types memory mtl network network-transport
    optparse-applicative process random record-hasfield simple-logger
    stm template-haskell text
    time tls unliftio unliftio-core uuid
  ]) ++ (with sourceDependencies; [
    aeson direct-sqlcipher sqlcipher-simple simplexmq socks terminal zip
    ansi-terminal constraints http2
  ]);

  executableHaskellDepends = (with haskellPackages; [
    async attoparsec base base64-bytestring
    bytestring composition containers crypton data-default
    directory email-validate exceptions filepath
    http-types memory mtl network network-transport
    optparse-applicative process random record-hasfield simple-logger
    stm template-haskell text
    time tls unliftio unliftio-core uuid websockets
  ]) ++ (with sourceDependencies; [
    aeson direct-sqlcipher sqlcipher-simple simplexmq socks terminal zip
    ansi-terminal constraints http2
  ]);

  testHaskellDepends = (with haskellPackages; [
    async attoparsec base base64-bytestring
    bytestring composition containers crypton data-default
    deepseq directory email-validate exceptions
    filepath generic-random hspec http-types memory mtl network
    network-transport optparse-applicative process QuickCheck random
    record-hasfield silently simple-logger
    stm template-haskell text time tls
    unliftio unliftio-core uuid
  ]) ++ (with sourceDependencies; [
    aeson direct-sqlcipher sqlcipher-simple simplexmq socks terminal zip
    ansi-terminal constraints http2
  ]);

  homepage = "https://github.com/simplex-chat/simplexmq#readme";
  description = "SimpleXMQ message broker";
  license = lib.licenses.agpl3Only;
  # mainProgram = "smp-server";
  platforms = [ "x86_64-linux" ];
  maintainers = with lib.maintainers; [ giorgiga ];
}
