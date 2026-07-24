function envsrc
    set -l options 'e/erase'
    argparse --min-args=0 --max-args=1 $options -- $argv || return

    set -l file $argv[1]
    if [ -z "$file" ]
        echo "Error: No .env file specified" >&2
        return 1
    end

    for line in (cat $file | grep -v '^#')
        set item (string split -m 1 '=' $line)
        set -l key $item[1]
        set -l value $item[2]

        if set -q _flag_e
            set -e $key
            echo "-$key"
        else
            set -xg $key $value
            echo "+$key"
        end
    end
end 
