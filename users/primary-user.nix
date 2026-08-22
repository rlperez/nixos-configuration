{ primary_username, ... }:

{
  home.username = primary_username;
  home.homeDirectory = "/home/${primary_username}";
  home.stateVersion = "26.05";
  home.file = {
    # Bash
    ".bashrc".source = ../config/shell/bash/.bashrc;
    ".bash_profile".source = ../config/shell/bash/.bash_profile;
    ".bash_aliases".source = ../config/shell/bash/.bash_aliases;

    # Environment
    ".config/shell/.env".source = ../config/shell/.env;
    ".config/shell/bash/.env".source = ../config/shell/bash/.env;

    # Fish
    ".config/fish" = {
      source = ../config/shell/fish;
      force = true;
      recursive = true;
    };
  };

  programs.fish = {
    enable = true;
    generateCompletions = true;
    shellInit = "source /home/${primary_username}/config/fish/config.fish";
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = false;
    presets = [ "nerd-font-symbols" "jetpack" ];
    settings = {
      add_newline = true;
      follow_symlinks = true;
    };
  };

  programs.ghostty = {
    enable = true;
    systemd = {
      enable = true;
    };
    settings = {
      font-family = "JetBrainsMono Nerd Font";
      quit-after-last-window-closed = true;
      quit-after-last-window-closed-delay = "5m";
    };
  };

  xdg.enable = true;
}
