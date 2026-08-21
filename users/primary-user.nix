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

  programs.starship = {
    enable = true;
    presets = [ "nerd-font-symbols" "jetpack" ];
    settings = { };
  };

  xdg.enable = true;
}
