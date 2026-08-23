{ pkgs, primary_username, ... }:

{
  home.username = primary_username;
  home.homeDirectory = "/home/${primary_username}";
  home.stateVersion = "26.05";
  home.file = {
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

  home.packages = with pkgs; [
    blesh
  ];

  programs.atuin = {
    enable = true;
    daemon.enable = true;
    enableBashIntegration = true;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      set -a
      source ~/.config/shell/.env
      source ~/.config/shell/bash/.env
      set +a
    '';
    historySize = 10000;
    initExtra = ''
      [[ $- == *i* ]] && source ${pkgs.blesh}/share/blesh/ble.sh;
    '';
    shellAliases = {
      ls = "/nix/var/nix/profiles/system/sw/bin/eza";
      l = "/nix/var/nix/profiles/system/sw/bin/eza -lah";
      ll = "/nix/var/nix/profiles/system/sw/bin/eza -l";
      la = "/nix/var/nix/profiles/system/sw/bin/eza -a";
      lt = "/nix/var/nix/profiles/system/sw/bin/eza --tree";
      lla = "/nix/var/nix/profiles/system/sw/bin/eza -la";
      zed = "/nix/var/nix/profiles/system/sw/bin/zeditor";
    };
    shellOptions = [
      "autocd"
      "cdspell"
      "checkwinsize"
      "globstar"
      "histappend"
    ];
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    extraOptions = [
      "--group-directories-first"
    ];
    git = true;
    icons = "auto";
  };

  programs.fastfetch = {
    enable = true;
  };

  programs.fish = {
    enable = true;
    generateCompletions = true;
    shellInit = "source /home/${primary_username}/config/fish/config.fish";
  };

  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    systemd = {
      enable = true;
    };
    settings = {
      font-family = "JetBrainsMono Nerd Font";
      quit-after-last-window-closed = true;
      quit-after-last-window-closed-delay = "5m";
    };
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = false;
    enableBashIntegration = true;
    presets = [ "nerd-font-symbols" "jetpack" ];
    settings = {
      add_newline = true;
      follow_symlinks = true;
    };
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };

  xdg.enable = true;
}
