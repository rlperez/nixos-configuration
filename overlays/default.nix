final: prev: {
  fishPlugins = prev.fishPlugins // {
    fish-eza = prev.callPackage ../pkgs/fish-eza.nix {
      buildFishPlugin = prev.fishPlugins.buildFishPlugin;
    };

    fish-logo = prev.callPackage ../pkgs/fish-logo.nix {
      buildFishPlugin = prev.fishPlugins.buildFishPlugin;
    };
  };
}
