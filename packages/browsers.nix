{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    brave
    librewolf
  ];

  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        brave
	librewolf
      '';
    };
  };
}
