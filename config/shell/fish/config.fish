function load_fish_in_path --argument dir
    for file in $dir/*.fish
        source $file
    end
end

load_fish_in_path $HOME/.config/fish/custom_sys_functions

if test -e $HOME/.env
    envsrc $HOME/.env
end

if status is-interactive
    if test -e $HOME/interactive.env
        envsrc $HOME/interactive.env
    end

    load_fish_in_path $HOME/.config/fish/custom_functions

    if type -q nvim
	set -xg EDITOR nvim
    else if type -q vim
	set -xg EDITOR vim
    else if type -q emacs
	set -xg EDITOR "emacs -nw"
    else if type -q micro
	set -xg EDITOR micro
    else if type -q nano
	set -xg EDITOR nano
    end

    # Commands to run in interactive sessions can go here
    if type -q zoxide
        zoxide init fish | source
    end

    if type -q atuin
        atuin init fish | source
    end

    if type -q onefetch
        onefetch --generate fish | source
    end

    if type -q but
        but completions fish | source
    end

    if type -q starship
        set -l starship_command (which starship)
        source ($starship_command init fish --print-full-init | psub)
    end

    if type -q dockerfmt
        alias dockfmt dockerfmt
    end

    if type -q tofu
        alias tf tofu
    else if type -q terraform
        alias tf terraform
    end

    alias src "source $HOME/.config/fish/config.fish"

    fish_logo (random_color) (random_color) (random_color)
end

set_path
