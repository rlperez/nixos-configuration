{ appimageTools,
  lib,
  sources,
  channel
}:

appimageTools.wrapType2 {
  pname = "logseq";
  inherit (sources."logs-${channel}")
    version
    src;

  extraPkgs = pkgs: [];

  meta = {
    description = "Logseq";
    homepage = "https://logseq.com";
    license = lib.licenses.agpl3;
    platforms = [ "x86_64-linux" ];
    mainProgram = "logseq";
  };
}
