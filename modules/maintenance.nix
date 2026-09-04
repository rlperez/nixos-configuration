{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    borgbackup
    borgmatic
    megacmd
    megasync
    rclone
  ];
}
