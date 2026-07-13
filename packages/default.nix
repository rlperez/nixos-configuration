{ ... }: {
  imports = [
    ./browsers.nix
    ./editors.nix
    ./gaming.nix
    ./tools.nix
    ./fish_plugins
    ./language_servers.nix
  ];
}
