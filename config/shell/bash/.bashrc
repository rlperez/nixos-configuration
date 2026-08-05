[[ $- != *i* ]] && return

shopt -s autocd
shopt -s cdspell
shopt -s checkwinsize
shopt -s globstar
shopt -s histappend

set -a
source ~/.config/shell/.env
source ~/.config/shell/bash/.env
set +a

eval "$(zoxide init bash)"

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

eval "$(direnv hook bash)"
