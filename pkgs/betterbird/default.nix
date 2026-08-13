{
  alsa-lib,
  autoPatchelfHook,
  channel,
  lib,
  makeDesktopItem,
  patchelfUnstable,
  sources,
  stdenv,
  wrapGAppsHook3,
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
      "Calendar"
    ];
    keywords = [
      "mail"
      "e-mail"
      "email"
      "rss"
      "calendar"
      "addressbook"
      "address book"
    ];
    mimeTypes = [
      "application/ics"
      "message/rfc822"
      "text/calendar"
      "text/x-vcard"
      "x-scheme-handler/mailto"
      "x-scheme-handler/webcal"
    ];
  };
in
stdenv.mkDerivation {
  pname = "betterbird";
  inherit (source) version src;

  buildInputs = [
    alsa-lib
  ];

  nativeBuildInputs = [
    autoPatchelfHook
    patchelfUnstable
    wrapGAppsHook3
  ];

  patchelfFlags = [
    "--no-clobber-old-sections"
  ];

  strictDeps = true;

  postPatch = ''
    # Don't allow Betterbird to update itself outside of Nix.
    echo 'pref("app.update.auto", "false");' >> defaults/pref/channel-prefs.js
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/usr/lib/betterbird"
    cp -r . "$out/usr/lib/betterbird"

    mkdir -p "$out/bin"
    ln -s "$out/usr/lib/betterbird/betterbird" "$out/bin/betterbird"

    # wrapThunderbird expects "$out/lib" rather than "$out/usr/lib".
    ln -s "$out/usr/lib" "$out/lib"

    mkdir -p "$out/share/applications"
    cp "${desktopItem}/share/applications/eu.betterbird.Betterbird.desktop" \
      "$out/share/applications/eu.betterbird.Betterbird.desktop"

    for size in 16 22 24 32 48 64 128 256; do
    mkdir -p "$out/share/icons/hicolor/$size"x"$size/apps"
    cp "$out/usr/lib/betterbird/chrome/icons/default/default$size.png" \
        "$out/share/icons/hicolor/$size"x"$size/apps/betterbird.png"
    done

    runHook postInstall
  '';

  meta = {
    changelog =
      "https://www.betterbird.eu/releasenotes/";
    description =
      "Betterbird is a fine-tuned version of Mozilla Thunderbird";
    homepage = "https://www.betterbird.eu";
    mainProgram = "betterbird";
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    license = lib.licenses.mpl20;
    platforms = [ "x86_64-linux" ];
  };
}
