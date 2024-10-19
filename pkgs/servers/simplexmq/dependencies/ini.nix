{
  lib,
  haskellPackages,
  fetchFromGitHub,
  callPackage,
  revisions
}:

haskellPackages.mkDerivation {
  pname = "ini";
  version = revisions.ini.version;
  src = fetchFromGitHub {
    owner = "andreasabel";
    repo = "ini";
    rev = revisions.ini.rev;
    hash = revisions.ini.hash;
  };
  libraryHaskellDepends = with haskellPackages; [ attoparsec unordered-containers ];
  testHaskellDepends    = with haskellPackages; [ hspec ];
  homepage = "http://github.com/chrisdone/ini";
  description = "Quick and easy configuration files in the INI format";
  license = lib.licenses.bsd3;
}
