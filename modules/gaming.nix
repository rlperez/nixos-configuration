{ pkgs, ... }: {
  programs.gamescope = {
    enable = true;
    enableWsi = true;
    capSysNice = false;
  };
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    protontricks.enable = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    heroic
    mangohud
    umu-launcher
  ];
}
