{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    megacmd
    megasync
    rclone
  ];
}
