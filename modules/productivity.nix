{ pkgs, ... }:
let
  kaccounts-integration = pkgs.kdePackages.kaccounts-integration;
  signon-kwallet-extension = pkgs.kdePackages.signon-kwallet-extension;
  signond = pkgs.kdePackages.signond;
in
{
  environment.systemPackages = with pkgs; [
    betterbird-release
    kaccounts-integration
    signon-kwallet-extension
    signond

    libreoffice-qt
    hyphenDicts.en_US
    hunspell
    hunspellDicts.en_US

    logseq-db
    newsflash
    speedcrunch
  ];
}
