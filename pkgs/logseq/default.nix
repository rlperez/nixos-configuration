{ appimageTools,
  lib,
  sources,
  channel
}:

appimageTools.wrapType2 {
  pname = "logseq";
  inherit (sources."logseq-${channel}")
    version
    src;

  extraPkgs = pkgs: [];

  meta = {
    description = "Logseq";
    homepage = "https://logseq.com";
    license = lib.licenses.agpl3Only;
    platforms = [ "x86_64-linux" ];
    mainProgram = "logseq";
  };
}
