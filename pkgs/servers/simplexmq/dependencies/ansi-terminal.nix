{
  lib,
  haskellPackages,
  fetchFromGitHub,
  callPackage,
  revisions
}:

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
}
