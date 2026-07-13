{ pkgs, ... }: 
{
  environment.systemPackages = with pkgs; [
    emacs
    zed-editor
  ];
}

