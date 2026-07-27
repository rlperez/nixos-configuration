final: prev:

let
  sources = import ../_sources/generated.nix {
    inherit (prev)
      fetchgit
      fetchurl
      fetchFromGitHub
      dockerTools;
  };
in {
  fishPlugins = prev.fishPlugins // {
    fish-eza = prev.fishPlugins.buildFishPlugin {
      inherit (sources.fish-eza)
        pname
        version
        src;
    };

    fish-logo = prev.fishPlugins.buildFishPlugin {
      inherit (sources.fish-logo)
        pname
        version
        src;
    };
  };

  logseq = prev.appimageTools.wrapType2 {
    inherit (sources.logseq)
      pname
      version
      src;

    meta = {
      description = "Logseq";
      homepage = "https://logseq.com";
      platforms = [ "x86_64-linux" ];
    };
  };
}
