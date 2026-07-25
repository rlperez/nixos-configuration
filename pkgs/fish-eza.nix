{
  buildFishPlugin,
  fetchFromGitHub,
}:
buildFishPlugin {
  pname = "fish-eza";
  version = "0-unstable-20260206";
  src = fetchFromGitHub {
    owner = "givensuman";
    repo = "fish-eza";
    rev = "fb2d8c70e6d894d3b55259e4c4e659a4850581b0";
    hash = "sha256-cFUHMSEMxq/XSeKOLCUArgM9ogY6NqrPmhxaHn5bbQs=";
  };
}
