{ config, lib, ... }:
{
  options.maintenance.repoPath = lib.mkOption {
    type = lib.types.path;
    description = "Path to the nixos-config checkout";
  };

  config = {
    systemd.services.flake-update = {
      description = "Update flake inputs";
      serviceConfig = {
        Type = "oneshot";
        User = "fr0bar";
        WorkingDirectory = config.maintenance.repoPath;
        ExecStart = "${config.maintenance.repoPath}/scripts/update-flake.sh";
      };
    };

    systemd.timers.flake-update = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "Mon..Sat 03:00";
        Persistent = true;
      };
    };

    systemd.services.update-all = {
      description = "Update all sources";
      serviceConfig = {
        Type = "oneshot";
        User = "fr0bar";
        WorkingDirectory = config.maintenance.repoPath;
        ExecStart = "${config.maintenance.repoPath}/scripts/update-all.sh";
      };
    };

    systemd.timers.update-all = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "Sun 03:00";
        Persistent = true;
      };
    };
  };
}
