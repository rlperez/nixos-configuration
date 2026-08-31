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
      format = "($nix_shell$container$fill$git_metrics\n)$cmd_duration$hostname$localip$shlvl$shell$env_var$jobs$sudo$username$character";
      right_format = ''
        $singularity
        $kubernetes
        $directory
        $vcsh
        $fossil_branch
        $git_branch
        $git_commit
        $git_state
        $git_status
        $hg_branch
        $pijul_channel
        $docker_context
        $package
        $all
        $memory_usage
        $aws
        $gcloud
        $openstack
        $azure
        $crystal
        $custom
        $status
        $os
        $battery
        $time'';
      aws = {
        disabled = false;
      };
      azure = {
        format = " [azure](italic) [$symbol $subscription](bold bright-blue)";
      };
      bun = {
        format = " [bun](italic) [$symbol ($version)](bold pink)";
      };
      directory = {
        truncation_length = 3;
      };
      dotnet = {
        format = " [dotnet](italic) [$symbol ($version)](bold bright-blue)";
      };
      fennel = {
        format = " [fennel](italic) [$symbol ($version)](bold white)";
      };
      git_branch = {
        truncation_length = 18;
      };
      nodejs = {
        format = " [nodejs](italic) [$symbol ($version)](bold bright-green)";
      };
      os = {
        disabled = false;
        format = "[$symbol ($version)](bold white)[⎥](bold italic bright-blue)";
      };
    };
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "/mnt/slow_storage/Home/${primary_username}/Desktop/";
      documents = "/mnt/slow_storage/Home/${primary_username}/Documents/";
      download = "/mnt/slow_storage/Home/${primary_username}/Downloads/";
      music = "/mnt/slow_storage/Home/${primary_username}/Music/";
      pictures = "/mnt/slow_storage/Home/${primary_username}/Pictures/";
      projects = "/home/${primary_username}/Projects/";
      templates = "/mnt/slow_storage/Home/${primary_username}/Templates/";
      videos = "/mnt/slow_storage/Home/${primary_username}/Videos/";
    };
  };
}
