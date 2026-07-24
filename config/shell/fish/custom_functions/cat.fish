# Utilizes bat when in user shell to get prettier code prints but
# reverts to cat when not to prevent interfering with other scripts.
function cat --description "alias cat bat"
    if status --is-interactive
	# Commands to run in interactive sessions can go here
	if type -q bat
	   set -f BATCMD bat
	else if type -q batcat
	   set -f BATCMD batcat
    	end

        if command -v $BATCMD > /dev/null
            # Initialize an empty list for the arguments
            set -l args
            for arg in $argv
                # Replace '-a' with '--pager=never' in each argument, if applicable
                if [ $arg = -a ]
                    set new_arg "--pager=never"
                else
                    set new_arg $arg
                end
                # Add the processed argument (either modified or unchanged) to the args list
                set args $args $new_arg
            end

            # In interactive mode, use bat
            command $BATCMD $args
        else
            command cat $argv
        end
    else
        # In non-interactive mode, use cat
        command cat $argv
    end
end
