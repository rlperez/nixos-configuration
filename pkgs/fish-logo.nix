{ lib,
  fishPlugins,
  sources
}:

fishPlugins.buildFishPlugin {
  pname = sources.fish-logo.pname;
  version = sources.fish-logo.version;
  src = sources.fish-logo.src;

  meta = {
    description = "Fish plugin that displays a random fish logo";
    homepage = "https://github.com/laughedelic/fish_logo";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
  };
}
