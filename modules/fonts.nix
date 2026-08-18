{ pkgs, ... }:
{
  fonts.packages = with pkgs; with nerd-fonts; [
    fira-code
    jetbrains-mono
    hack
    hasklug
    symbols-only
  ];
}
