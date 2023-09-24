# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Set window title
PROMPT_COMMAND='printf "\033]0;%s:%s\007" "${USER}" "${PWD/#$HOME/\~}"'

# Shell options
shopt -s checkwinsize
shopt -s expand_aliases
shopt -s histappend
HISTCONTROL=ignoreboth
HISTSIZE=-1

# User colors
if [[ -f ~/.dir_colors ]] ; then
  eval $(dircolors -b ~/.dir_colors)
fi

# Aliases for interactive shells only
alias grep='grep --colour=auto'
alias egrep='grep --colour=auto'
alias fgrep='grep --colour=auto'
case ":${PATH}:" in
  *:"/usr/local/bin/alias":*) ;;
  *) export PATH="/usr/local/bin/alias:$PATH" ;;
esac

# Set pager
export PAGER='most -w'
export SYSTEMD_PAGERSECURE=1
export SYSTEMD_PAGER='most -w'

# Set prompt
if [[ ${EUID} == 0 ]] ; then
    PS1='\[\033[01;35m\]\w \$\[\033[00m\] '
else
    PS1='\[\033[01;34m\]\w \$\[\033[00m\] '
fi
