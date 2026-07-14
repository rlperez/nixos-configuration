{ pkgs, ... }:
{
  programs.neovim.enable = true;
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };

  environment.systemPackages = with pkgs; [
    emacs
    zed-editor
  ];
}
