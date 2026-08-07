{ lib,
  stdenv,
  makeWrapper,
  sources,
  channel,
}:
# TODO: Review the deployment instructions.
let
  source = sources."betterbird-${channel}";
in
stdenv.mkDerivation {
  pname = "betterbird";
  inherit (source) version src;

  nativeBuildInputs = [
    makeWrapper
  ];

  installPhase = ''
    mkdir -p $out/lib/betterbird
    cp -r . $out/lib/betterbird

    mkdir -p $out/bin

    makeWrapper \
      $out/lib/betterbird/betterbird \
      $out/bin/betterbird
  '';

  postFixup = ''
    wrapProgram $out/lib/betterbird/betterbird \
      --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [
        stdenv.cc.cc
      ]}
  '';

  meta = {
    description = "Betterbird email client (${channel})";
    homepage = "https://www.betterbird.eu/";
    license = lib.licenses.mpl20;
    platforms = [ "x86_64-linux" ];
    mainProgram = "betterbird";
  };
}
