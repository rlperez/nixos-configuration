{ config, lib, pkgs, primary_username, ... }:
{
  options.maintenance.repoPath = lib.mkOption {
    type = lib.types.path;
    description = "Path to the nixos-config checkout";
  };

  config = {
    systemd.services = {
      update-daily = {
        description = "Update flake inputs";
        path = with pkgs; [
          bash
          git
          nix
        ];
        serviceConfig = {
          Type = "oneshot";
          User = primary_username;
          Group = "users";
          WorkingDirectory = config.maintenance.repoPath;
          ExecStart = "${config.maintenance.repoPath}/scripts/daily.sh";
        };
      };
      update-weekly = {
        description = "Update all sources";
        path = with pkgs; [
          bash
          git
          nix
        ];
        serviceConfig = {
          Type = "oneshot";
          User = primary_username;
          Group = "users";
          WorkingDirectory = config.maintenance.repoPath;
          ExecStart = "${config.maintenance.repoPath}/scripts/weekly.sh";
        };
      };
    };

    systemd.timers = {
      flake-update = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnCalendar = "Mon..Sat 10:00";
          Persistent = true;
        };
      };
      update-all = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnCalendar = "Sun 10:00";
          Persistent = true;
        };
      };
    };
  };
}
