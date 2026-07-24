{ pkgs, ... }: {
  programs.bash.enable = true;
  programs.fish = {
    enable = true;
    vendor = {
      config.enable = true;
      completions.enable = true;
      functions.enable = true;
    };
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
    fishPlugins.fish-eza
    fishPlugins.fish-logo
  ];
}
