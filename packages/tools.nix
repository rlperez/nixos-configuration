{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    ansible
    eza
    fzf
    ghostty
    gitbutler
    fastfetch
    kubectl
    onefetch
    podman-compose
    podman-desktop
    ripgrep
    vault
  ];
}

