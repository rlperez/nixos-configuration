{ ... }:

{
  home.username = "fr0bar";
  home.homeDirectory = "/home/fr0bar";
  home.stateVersion = "26.05";
  home.file = {
    # Bash
    ".bashrc".source = ../config/shell/bash/.bashrc;
    ".bash_profile".source = ../config/shell/bash/.bash_profile;
    ".bash_aliases".source = ../config/shell/bash/.bash_aliases;

    # Environment
    ".config/shell/.env".source = ../config/shell/.env;
    ".config/shell/bash/.env".source = ../config/shell/bash/.env;
    ".config/fish" = {
      source = ../config/shell/fish;
      force = true;
      recursive = true;
    };
  };


  xdg.enable = true;
}
