{ config, lib, pkgs, ... }:
let
  git_author_name = "NixOS Auto-upgrade";
  git_author_email = "root@&lt;${config.maintenance.hostName}&gt;";
  git_committer_name = "NixOS Auto-upgrade";
  git_committer_email = "root@&lt;${config.maintenance.hostName}&gt;";
in
{
  options.maintenance = {
    repoPath = lib.mkOption {
      type = lib.types.path;
      description = "Path to the nixos-config checkout";
    };
    hostName = lib.mkOption {
      type = lib.types.str;
      description = "Computer hostname";
    };
  };

  config = {
    systemd.services = {
      nixos-upgrade.environment = {
        GIT_AUTHOR_NAME = git_author_name;
        GIT_AUTHOR_EMAIL = git_author_email;
        GIT_COMMITTER_NAME = git_committer_name;
        GIT_COMMITTER_EMAIL = git_committer_email;
      };

      update-daily = {
        description = "Update nvfetcher packages";
        environment = {
          REPO_PATH = config.maintenance.repoPath;
          GIT_AUTHOR_NAME = git_author_name;
          GIT_AUTHOR_EMAIL = git_author_email;
          GIT_COMMITTER_NAME = git_committer_name;
          GIT_COMMITTER_EMAIL = git_committer_email;
        };
        path = with pkgs; [
          bash
          curl
          git
          jq
          nix
          nixos-rebuild
          util-linux
        ];
        serviceConfig = {
          Type = "oneshot";
          WorkingDirectory = config.maintenance.repoPath;
          ExecStart = "${config.maintenance.repoPath}/scripts/daily.sh";
        };
      };
    };

    systemd.timers = {
      update-daily = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnCalendar = "5:00";
          Persistent = true;
        };
      };
    };
  };
}
