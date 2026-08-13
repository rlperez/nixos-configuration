{ lib,
  fishPlugins,
  sources
}:

fishPlugins.buildFishPlugin {
  pname = sources.fish-eza.pname;
  version = sources.fish-eza.version;
  src = sources.fish-eza.src;

  meta = {
    description = "Fish plugin providing eza integration";
    homepage = "https://github.com/givensuman/fish-eza";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
  };
}
