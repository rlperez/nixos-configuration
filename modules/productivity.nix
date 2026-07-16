{ pkgs, ... }:
let
  kmail = pkgs.kdePackages.kmail;
  kmail-account-wizard = pkgs.kdePackages.kmail-account-wizard;
in
{
  environment.systemPackages = with pkgs; [
    kmail
    kmail-account-wizard
    newsflash
  ];
}
