function random_color
    set -l hex_chars 0123456789ABCDEF
    set -l color "#"
    for i in (seq 1 6)
        set color "$color"(echo $hex_chars | string split '' | shuf -n1)
    end
    echo $color
end
