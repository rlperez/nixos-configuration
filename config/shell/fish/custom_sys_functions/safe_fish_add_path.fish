function safe_fish_add_path --argument exec_path
    if not functions -q should_add_path
        source $HOME/.config/fish/custom_sys_functions/should_add_path.fish
    end

    if should_add_path $exec_path
        fish_add_path $exec_path
    end
end
