rec {
  # These are forks by SimpleX:
  aeson = {
    rev = "aab7b5a14d6c5ea64c64dcaee418de1bb00dcc2b";
    version = "2.2.1.0";
    hash = "sha256-OTuJENv5I+9bWy6crllDm1lhkncmye33SCiqh1Sb50s=";
  };
  attoparsec-aeson = aeson; # subproject of aeson
  direct-sqlcipher = {
    rev = "f814ee68b16a9447fbb467ccc8f29bdd3546bfd9";
    version = "2.3.28";
    hash = "sha256-9/K1pnUnUTLj6OV5neQF6bDrQvtgi0a4VekJQuuGPE4=";
  };
  socks = {
    rev = "a30cc7a79a08d8108316094f8f2f82a0c5e1ac51";
    version = "0.6.1";
    hash = "sha256-aEgouR5om+yElV5efcsLi+4plvq7qimrOTOkd7LdWnk=";
  };
  sqlcipher-simple = {
    rev = "a46bd361a19376c5211f1058908fc0ae6bf42446";
    version = "0.4.18.1";
    hash = "sha256-9JV2odagCkUWUGEe8dWmqHfjcBmn6rf6FAEBhxo6Gfw=";
  };
  # These are (direct and transitive) depencencies needed in a version
  #   unavailbale in nixpkgs:
  aeson-pretty = rec {
    rev = "4678b295a04422533e22344be427e8f721ee390a";
    # repo is not properly tagged
    # 0.8.9  ==> 893fc5166bfaef680740abc27767769dbaad6549
    # 0.8.10 ==> 4678b295a04422533e22344be427e8f721ee390a allows aeson 2.1
    #        ==> 816334b02025a05fa5606810f996d430f1500b44 allows aeson 2.2
    # HEAD   ==> fcc4e96baf7deca8437d75108a56862e9bf40751
    version = "0.8.10";
    hash = "sha256-y1eXzNB6/2lkyYEIcgAan9atf5Dp7SlO4ASBkcDx1GI=";
  };
  ansi-terminal = rec {
    rev = "v${version}";
    version = "0.11.5";
    hash = "sha256-fOFwGLwrpH5W6K0/yaNsbxb9N02fFIiZNotbeu+6z5I=";
  };
  constraints = rec {
    rev = "v${version}";
    version = "0.13.4";
    hash = "sha256-jQRsNW2LsABx1L9Fnaalomb21jYzev9ODfxj+Za+RlU=";
  };
  http2 = rec {
    rev = "v${version}";
    version = "4.2.2";
    hash = "sha256-ZiG0vBtm8FZW1Lpe6zJnBMkzfq0iiEtjShXudwgA3Ts=";
  };
  ini = rec {
    rev = "${version}";
    version = "0.4.1";
    hash = "sha256-Pp/OoRO/YqV7sS6KOf2uLCty3JdUzRae2DmEVOvT9BY=";
  };
  network-transport = rec {
    version = "0.5.6";
    hash = "sha256-4Ig8/8rUGEAP/9HwWCjs7ATHt8xDlNKbFtwAaUyGLII=";
  };
  transformers = {
    version = "0.5.6.2";
    hash = "sha256-tmh5XWACl+TIp/1VoQe5gnssUsC8FMXqDWXiDmaRxmw=";
  };
}
