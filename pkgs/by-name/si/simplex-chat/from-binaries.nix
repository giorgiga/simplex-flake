{
  stdenv, lib, fetchurl, autoPatchelfHook,
  gmp, openssl, zlib
}:

stdenv.mkDerivation rec {
  pname = "simplex-chat";
  version = "6.0.5";

  dontUnpack = true;

  binary = fetchurl {
    url = "https://github.com/simplex-chat/simplex-chat/releases/download/v${version}/simplex-chat-ubuntu-22_04-x86-64";
    hash = "sha256-SVcsoFzwh2wk/XpTVqG7og6Wc2W0RjH0T3YnYmaAVIc=";
  };

  installPhase = ''
    runHook preInstall
    install -m755 -D '${binary}' $out/bin/simplex-chat
    runHook postInstall
  '';

  nativeBuildInputs = [ autoPatchelfHook ];

  buildInputs = [ gmp openssl zlib ];

  meta = {
    homepage = "https://simplex.chat/";
    downloadPage = "https://github.com/simplex-chat/simplex-chat/releases/tag/v${version}";
    description = "Simplex Chat CLI";
    mainProgram = "simplex-chat";
    license = lib.licenses.agpl3Only;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    platforms = [ "x86_64-linux" ];
    maintainers = with lib.maintainers; [ giorgiga ];
  };

}
