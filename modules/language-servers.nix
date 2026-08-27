{ pkgs, ... }:
let
  elm-ls = pkgs.elmPackages.elm-language-server;
in
{
  environment.systemPackages = with pkgs; [
    ansible-language-server
    ansible-lint
    clojure-lsp
    elixir-ls
    elm-ls
    fish-lsp
    jdt-language-server
    nixd
    terraform-ls
    typescript-language-server
    vscode-langservers-extracted
  ];
}
