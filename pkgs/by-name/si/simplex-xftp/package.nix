{
  stdenv, lib, fetchurl, autoPatchelfHook,
  gmp, openssl, zlib
}:

stdenv.mkDerivation rec {
  pname = "simplex-xftp";
  version = "6.0.6"; # see https://github.com/simplex-chat/simplexmq/issues/1368

  dontUnpack = true;

  binary = fetchurl {
    url = "https://github.com/simplex-chat/simplexmq/releases/download/v${version}/xftp-ubuntu-22_04-x86-64";
    hash = "sha256-MPo+Zgrg05q0ZakrpkuU/dozAJtXQrEgsje/IOE5iX0=";
  };

  installPhase = ''
    runHook preInstall
    install -m755 -D '${binary}' $out/bin/xftp
    runHook postInstall
  '';

  nativeBuildInputs = [ autoPatchelfHook ];

  buildInputs = [ gmp openssl zlib ];

  meta = {
    homepage = "https://simplex.chat/";
    downloadPage = "https://github.com/simplex-chat/simplexmq/releases/tag/v${version}";
    description = "Simplex Chat XFTP client";
    mainProgram = "simplex-xftp";
    license = lib.licenses.agpl3Only;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    platforms = [ "x86_64-linux" ];
    maintainers = with lib.maintainers; [ giorgiga ];
  };

}
