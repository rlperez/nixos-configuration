{ pkgs, ... }:
{
  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    packages = with pkgs; with nerd-fonts; [
      fira-code
      jetbrains-mono
      hack
      hasklug
      iosevka
      noto
      symbols-only
      zed-mono
    ];
  };
}
