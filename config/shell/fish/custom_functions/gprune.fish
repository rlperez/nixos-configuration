# Function to prune local branches not tracked in remote...be careful
function gprune --description "Prunes local branches no longer tracked in remote"
    for branch in (git branch -vv | grep ': gone]' | awk '{print $1}')
        git branch -D $branch
    end
end
