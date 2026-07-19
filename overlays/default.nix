final: prev: {
  fishPlugins = prev.fishPlugins // {
    fish-eza = prev.callPackage ../pkgs/fish-eza.nix {
      buildFishPlugin = prev.fishPlugins.buildFishPlugin;
    };

    fish-logo = prev.callPackage ../pkgs/fish-logo.nix {
      buildFishPlugin = prev.fishPlugins.buildFishPlugin;
    };
  };

  logseq = prev.appimageTools.wrapType2 {
    pname = "logseq";
    version = "2.0.1";

    src = prev.fetchurl {
      url = "https://github.com/logseq/logseq/releases/download/2.0.1/Logseq-linux-x86_64-2.0.1.AppImage";
      hash = "sha256-Sd42cHizdnD+vbmH5WK3Xe4eGulsKL+4c4d5xCKX3Qw=";
    };

    meta = {
      description = "Logseq";
      homepage = "https://logseq.com";
      platforms = [ "x86_64-linux" ];
    };
  };
}
