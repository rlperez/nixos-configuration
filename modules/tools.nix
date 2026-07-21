{ config, pkgs, ... }: {
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "fr0bar" ];
  };
  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = false;
    settings = {
      dir = "~/.atuin/logs";
      secrets_filter = true;
      show_numeric_shortcuts = true;
      store_failed = true;
      style = "full";
      update_check = false;
    };
  };
  programs.git.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.starship = {
    enable = true;
    interactiveOnly = true;
  };
  programs.zoxide.enable = true;

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  environment.systemPackages = with pkgs; [
    dotenvx
    eza
    fzf
    ghostty
    gitbutler
    fastfetch
    kubectl
    onefetch
    p7zip
    podman-compose
    podman-desktop
    ripgrep
  ];
}
