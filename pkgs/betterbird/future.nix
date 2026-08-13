{ callPackage, sources }:

callPackage ./default.nix {
  inherit sources;
  channel = "future";
}
