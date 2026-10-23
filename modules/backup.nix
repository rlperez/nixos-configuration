{ pkgs, ... }:

let
  resticRepo = "/mnt/slow_storage/restic";
  megaBucket = "restic-desktop-backups";

  rcloneSyncCmd = pkgs.writeShellScript "mega-sync" ''
    set -euo pipefail
    ${pkgs.rclone}/bin/rclone sync \
      ${resticRepo} \
      mega-s3:${megaBucket}/restic \
      --transfers 4 \
      --checkers 8 \
      --log-level INFO \
      --log-file /var/log/mega-sync.log
  '';
in
{
  services.restic.backups.local = {
    user = "root";
    repository = resticRepo;
    initialize = true;
    passwordFile = "/etc/restic/password";

    paths = [
      "/home"
      "/etc"
      "/root"
      "/var/lib"
      "/srv"
      "/boot"
    ];

    exclude = [
      "/mnt"
      "/media"
      "/run"
      "/tmp"
      "/proc"
      "/sys"
      "/dev"
      "/nix/store"
      "/nix/var"
      "/var/cache"
      "/var/tmp"
      "/root/.cache"
      "/home/*/.cache"
      "/home/*/node_modules"
      "/home/*/.cargo/registry"
      "/home/*/.cargo/git"
      "/home/*/.rustup/toolchains"
      "/home/*/go/pkg"
      "/home/*/.gradle/caches"
      "/home/*/.m2/repository"
      "/var/lib/libvirt/images"
      "/var/lib/docker"
      "/var/lib/containers"
      "/home/*/VirtualBox VMs"
      "/home/*/.local/share/Steam"
      "/home/*/.steam"
      "*.tmp"
      "*~"
      "*.swp"
    ];

    pruneOpts = [
      "--keep-daily"    "7"
      "--keep-weekly"  "5"
      "--keep-monthly" "12"
      "--keep-yearly"   "1"
    ];

    timerConfig = {
      OnCalendar = "daily";
      RandomizedDelaySec = "30m";
      Persistent = true;
    };
  };

  systemd.services."restic-backups-local".serviceConfig = {
    ExecStartPost = [ "${rcloneSyncCmd}" ];
    EnvironmentFile = [ "/etc/restic/mega-s3.env" ];
  };

  systemd.services.restic-check = {
    description = "Verify restic repository integrity";
    serviceConfig = {
      Type = "oneshot";
      User = "root";
      Environment = [
        "RESTIC_REPOSITORY=${resticRepo}"
        "RESTIC_PASSWORD_FILE=/etc/restic/password"
      ];
      ExecStart = [
        "${pkgs.restic}/bin/restic check"
        "${pkgs.restic}/bin/restic check --read-data-subset=5%"
      ];
    };
  };

  systemd.timers.restic-check = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "monthly";
      Persistent = true;
    };
  };
}
