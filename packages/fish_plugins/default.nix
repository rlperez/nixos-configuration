{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
  };

  environment.systemPackages = with pkgs; [
    fishPlugins.async-prompt
    fishPlugins.autopair
    fishPlugins.bass
    fishPlugins.colored-man-pages
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.git-abbr
    fishPlugins.humantime-fish
    fishPlugins.plugin-sudope
    fishPlugins.puffer
    fishPlugins.sponge

    # Use 3rd-party fish plugins manually packaged.
    (pkgs.callPackage ./fish-eza.nix { inherit (pkgs.fishPlugins) buildFishPlugin; } )
    (pkgs.callPackage ./fish_logo.nix { inherit (pkgs.fishPlugins) buildFishPlugin; } )
  ];
}
