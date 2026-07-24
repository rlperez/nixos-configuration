function set_path
  if not functions -q safe_fish_add_path
    source $HOME/.config/fish/custom_sys_functions/safe_fish_add_path.fish
  end

  set -l bun_path $HOME/.bun/bin
  safe_fish_add_path $bun_path

  set -l cargo_path $HOME/.cargo/bin
  safe_fish_add_path $cargo_path

  set -l home_bin_path $HOME/bin
  safe_fish_add_path $home_bin_path

  set -l home_local_bin_path $HOME/.local/bin
  safe_fish_add_path $home_local_bin_path

  set -l doom_bin_path $HOME/.emacs.d/bin
  safe_fish_add_path $doom_bin_path

  set -l go_bin_path "$(string replace -r '/[^/]*$' '' -- (which go 2>&1))"
  safe_fish_add_path $go_bin_path

  set -l go_bin_install_path "$HOME/go/bin"
  set -xg GOBIN $go_bin_install_path
  safe_fish_add_path $GOBIN

  set -l mason_lsp_path $HOME/.local/share/nvim/mason/bin
  safe_fish_add_path $mason_lsp_path
end
