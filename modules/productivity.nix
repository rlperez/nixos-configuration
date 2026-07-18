{ pkgs, ... }:
let
  kmail = pkgs.kdePackages.kmail;
  kmail-account-wizard = pkgs.kdePackages.kmail-account-wizard;
  kaccounts-integration = pkgs.kdePackages.kaccounts-integration;
  signon-kwallet-extension = pkgs.kdePackages.signon-kwallet-extension;
  signond = pkgs.kdePackages.signond;
in
{
  environment.systemPackages = with pkgs; [
    # KMail and dependencies
    kmail
    kmail-account-wizard
    kaccounts-integration
    signon-kwallet-extension
    signond

    logseq
    # RSS reader
    newsflash
  ];
}
