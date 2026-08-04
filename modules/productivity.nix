{ pkgs, ... }:
let
  kaccounts-integration = pkgs.kdePackages.kaccounts-integration;
  signon-kwallet-extension = pkgs.kdePackages.signon-kwallet-extension;
  signond = pkgs.kdePackages.signond;
in
{
  environment.systemPackages = with pkgs; [
    mailspring
    # KMail and dependencies
    kaccounts-integration
    signon-kwallet-extension
    signond

    logseq
    # RSS reader
    newsflash
  ];
}
