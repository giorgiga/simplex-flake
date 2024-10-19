{
  lib,
  haskellPackages,
  fetchFromGitHub,
  callPackage,
  revisions
}:

let
  aeson            = callPackage ./aeson.nix { inherit revisions; };
  attoparsec-aeson = callPackage ./attoparsec-aeson.nix { inherit revisions; };
in haskellPackages.mkDerivation {
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
}
