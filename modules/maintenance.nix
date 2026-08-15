{ config, lib, pkgs, ... }:
{
  options.maintenance = {
    repoPath = lib.mkOption {
      type = lib.types.path;
      description = "Path to the nixos-config checkout";
    };

    user = lib.mkOption {
      type = lib.types.str;
      description = "User that owns the nixos-config checkout";
    };
  };

  config = {
    systemd.services = {
      update-daily = {
        description = "Update flake inputs";
        environment = {
          REPO_PATH = config.maintenance.repoPath;
          GIT_USERNAME = config.maintenance.user;
        };
        path = with pkgs; [
          bash
          git
          nix
          util-linux
        ];
        serviceConfig = {
          Type = "oneshot";
          WorkingDirectory = config.maintenance.repoPath;
          ExecStart = "${config.maintenance.repoPath}/scripts/daily.sh";
        };
      };
      update-weekly = {
        description = "Update all sources";
        environment = {
          REPO_PATH = config.maintenance.repoPath;
          GIT_USERNAME = config.maintenance.user;
        };
        path = with pkgs; [
          bash
          git
          nix
          util-linux
        ];
        serviceConfig = {
          Type = "oneshot";
          WorkingDirectory = config.maintenance.repoPath;
          ExecStart = "${config.maintenance.repoPath}/scripts/weekly.sh";
        };
      };
    };

    systemd.timers = {
      update-daily = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnCalendar = "Mon..Sat 5:00";
          Persistent = true;
        };
      };
      update-weekly = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnCalendar = "Sun 5:00";
          Persistent = true;
        };
      };
    };
  };
}
