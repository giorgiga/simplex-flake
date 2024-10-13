{
  stdenv, lib, fetchurl, autoPatchelfHook,
  gmp, openssl, zlib
}:

stdenv.mkDerivation rec {
  pname = "simplex-xftp-server";
  version = "6.0.6";

  dontUnpack = true;

  binary = fetchurl {
    url = "https://github.com/simplex-chat/simplexmq/releases/download/v${version}/xftp-server-ubuntu-22_04-x86-64";
    hash = "sha256-qyDKh9hhbzMo0+Nd3UbcGdR+eLE3+6lj7u7QLGIoE4c=";
  };

  installPhase = ''
    runHook preInstall
    install -m755 -D '${binary}' $out/bin/simplex-xftp-server
    runHook postInstall
  '';

  nativeBuildInputs = [ autoPatchelfHook ];

  buildInputs = [ gmp openssl zlib ];

  meta = {
    homepage = "https://simplex.chat/";
    downloadPage = "https://github.com/simplex-chat/simplexmq/releases/tag/v${version}";
    description = "Simplex Chat XFTP server";
    mainProgram = "simplex-xftp-server";
    license = lib.licenses.agpl3Only;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    platforms = [ "x86_64-linux" ];
    maintainers = with lib.maintainers; [ giorgiga ];
  };

}
