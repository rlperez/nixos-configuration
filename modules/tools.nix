{ pkgs, ... }: {
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "fr0bar" ];
  };
  programs.atuin = {
    enable = true;
    settings = {
      dir = "~/.atuin/logs";
      secrets_filter = true;
      show_numeric_shortcuts = true;
      store_failed = true;
      style = "full";
      update_check = false;
    };
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    settings = {
      global = {
        hide_env_diff = true;
        load_dotenv = true;
        strict_env = true;
      };
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
    direnv
    dotenvx
    eza
    fzf
    ghostty
    gitbutler
    fastfetch
    jq
    kubectl
    nix-direnv
    onefetch
    p7zip
    podman-compose
    podman-desktop
    ripgrep
    tre
  ];
}
