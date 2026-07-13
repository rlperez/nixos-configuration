{
  lib,
  buildFishPlugin,
  fetchFromGitHub,
}:
buildFishPlugin {
  pname = "fish-eza";
  version = "0-unstable-20201126";
  src = fetchFromGitHub {
    owner = "laughedelic";
    repo = "fish_logo";
    rev = "dc6a40836de8c24c62ad7c4365aa9f21292c3e6e";
    hash = "sha256-DZXQt0fa5LdbJ4vPZFyJf5FWB46Dbk58adpHqbiUmyY=";
  };
}

