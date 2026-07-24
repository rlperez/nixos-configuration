function should_add_path --argument dir
    test -d $dir; and not contains $dir $PATH
end
