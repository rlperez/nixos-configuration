{ pkgs, ... }:
{
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    brave-origin
    librewolf
  ];

  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        brave-origin
        librewolf
      '';
    };
  };
}
