{
  stdenv, lib, fetchurl, autoPatchelfHook,
  gmp, openssl, zlib
}:

stdenv.mkDerivation rec {
  pname = "simplexmq-smp-server";
  version = "6.0.6";

  dontUnpack = true;

  binary = fetchurl {
    url = "https://github.com/simplex-chat/simplexmq/releases/download/v${version}/smp-server-ubuntu-22_04-x86-64";
    hash = "sha256-Knw0h0OM9bmuQLz5lRnUFV2BVKuQRTf9YIJGpA68ENQ=";
  };

  installPhase = ''
    runHook preInstall
    install -m755 -D '${binary}' $out/bin/smp-server
    runHook postInstall
  '';

  nativeBuildInputs = [ autoPatchelfHook ];

  buildInputs = [ gmp openssl zlib ];

  meta = {
    homepage = "https://simplex.chat";
    downloadPage = "https://github.com/simplex-chat/simplexmq/releases/tag/v${version}";
    description = "Simplex Chat SMP server";
    mainProgram = "smp-server";
    license = lib.licenses.agpl3Only;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    platforms = [ "x86_64-linux" ];
    maintainers = with lib.maintainers; [ giorgiga ];
  };

}
