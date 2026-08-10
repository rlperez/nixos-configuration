{
  lib,
  stdenv,
  makeWrapper,
  makeDesktopItem,
  sources,
  channel,
}:

let
  source = sources."betterbird-${channel}";

  desktopItem = makeDesktopItem {
    name = "eu.betterbird.Betterbird";
    desktopName = "Betterbird";
    exec = "betterbird %u";
    icon = "betterbird";
    type = "Application";
    categories = [
      "Office"
      "Email"
    ];
    mimeTypes = [
      "x-scheme-handler/mailto"
    ];
  };
in
stdenv.mkDerivation {
  pname = "betterbird";
  inherit (source) version src;

  nativeBuildInputs = [
    makeWrapper
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/lib/betterbird"
    cp -r . "$out/lib/betterbird"

    mkdir -p "$out/bin"
    makeWrapper \
      "$out/lib/betterbird/betterbird" \
      "$out/bin/betterbird"

    mkdir -p "$out/share/icons/hicolor/256x256/apps"
    cp "$out/lib/betterbird/chrome/icons/default/default256.png" \
      "$out/share/icons/hicolor/256x256/apps/betterbird.png"

    mkdir -p "$out/share/applications"
    cp "${desktopItem}/share/applications/eu.betterbird.Betterbird.desktop" \
      "$out/share/applications/"

    runHook postInstall
  '';

  meta = {
    description = "Betterbird email client (${channel})";
    homepage = "https://www.betterbird.eu/";
    license = lib.licenses.mpl20;
    platforms = [ "x86_64-linux" ];
    mainProgram = "betterbird";
  };
}
