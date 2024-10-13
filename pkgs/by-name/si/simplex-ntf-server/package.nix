{
  stdenv, lib, fetchurl, autoPatchelfHook,
  gmp, openssl, zlib
}:

stdenv.mkDerivation rec {
  pname = "simplex-ntf-server";
  version = "6.0.6";

  dontUnpack = true;

  binary = fetchurl {
    url = "https://github.com/simplex-chat/simplexmq/releases/download/v${version}/ntf-server-ubuntu-22_04-x86-64";
    hash = "sha256-ZWQPZ+/rYrPGBfuMcKBocDcnFVGmDA0WlZb6j5yGa6E=";
  };

  installPhase = ''
    runHook preInstall
    install -m755 -D '${binary}' $out/bin/ntf-server
    runHook postInstall
  '';

  nativeBuildInputs = [ autoPatchelfHook ];

  buildInputs = [ gmp openssl zlib ];

  meta = {
    homepage = "https://simplex.chat/";
    downloadPage = "https://github.com/simplex-chat/simplexmq/releases/tag/v${version}";
    description = "Simplex Chat NTF server";
    mainProgram = "simplex-ntf-server";
    license = lib.licenses.agpl3Only;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    platforms = [ "x86_64-linux" ];
    maintainers = with lib.maintainers; [ giorgiga ];
  };

}
