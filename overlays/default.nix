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
  betterbird = final.callPackage ../pkgs/betterbird/release.nix {
    inherit sources;
  };

  betterbird-future = final.callPackage ../pkgs/betterbird/future.nix {
    inherit sources;
  };

  fishPlugins = prev.fishPlugins // {
    fish-eza = final.callPackage ../pkgs/fish-eza.nix {
      inherit sources;
    };

    fish-logo = final.callPackage ../pkgs/fish-logo.nix {
      inherit sources;
    };
  };

  logseq-db = final.callPackage ../pkgs/logseq/database.nix {
    inherit sources;
  };

  logseq = final.callPackage ../pkgs/logseq/markdown.nix {
    inherit sources;
  };
}
