{ pkgs, ... }:
let
  elm-ls = pkgs.elmPackages.elm-language-server;
in
{
  environment.systemPackages = with pkgs; [
    clojure-lsp
    elixir-ls
    elm-ls
    fish-lsp
    jdt-language-server
    nixd
    typescript-language-server
    vscode-langservers-extracted
  ];
}
