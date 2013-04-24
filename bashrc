# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Source custom libs
if [ -d $HOME/.bash/libs ]; then for lib in $(ls $HOME/.bash/libs/*.bash); do source $lib; done; fi

# Source alias definitions
if [ -f $HOME/.bash_aliases ]; then source $HOME/.bash_aliases; fi
if [ -f $HOME/.bash/aliases ]; then source $HOME/.bash/aliases; fi
if [ -d $HOME/.bash/aliases ]; then for file in $(ls $HOME/.bash/aliases/*); do source $file; done; fi
if [ -d $HOME/.bash/aliases.d ]; then for file in $(ls $HOME/.bash/aliases.d/*); do source $file; done; fi

# Source bash completion definitions
[[ -f /etc/bash-completion ]] && source /etc/bash-completion
[[ -f /etc/profile.d/bash-completion ]] && source /etc/profile.d/bash-completion
if [ -f $HOME/.bash_completion ]; then source $HOME/.bash_completion; fi
if [ -f $HOME/.bash/completion ]; then source $HOME/.bash/completion; fi
if [ -d $HOME/.bash/completion ]; then for file in $(ls $HOME/.bash/completion/*); do source $file; done; fi
if [ -d $HOME/.bash/completion.d ]; then for file in $(ls $HOME/.bash/completion.d/*); do source $file; done; fi

# Customize the prompt
if [ "$UID" -eq 0 ]; then
  export PS1='\[\e[01;31m\]\u@\h\[\e[01;34m\] \w \$\[\e[0m\] '
else
  export PS1='\[\e[01;32m\]\u@\h\[\e[01;34m\] \w \$\[\e[0m\] '
fi

smiley() {
    ret_val=$?
    if [ "$ret_val" = "0" ]
    then
        echo -e "\e[01;32m:)\e[0m" 
    else
        echo -e "\e[01;31m:(\e[0m" 
    fi
}

#export PS1='\[\e[01;32m\]\u@\h\[\e[01;34m\] \w \$\[\e[0m\] '"\$(smiley) "

# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
if [[ -f ~/.dir_colors ]]; then
	eval `dircolors -b ~/.dir_colors`
elif [[ -f /etc/DIR_COLORS ]]; then
	eval `dircolors -b /etc/DIR_COLORS`
fi

# Change the window title of X terminals 
case $TERM in
	xterm*|rxvt*|urxvt*|Eterm)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
		;;
	screen*)
                PROMPT_COMMAND='echo -ne "\033k${USER}@${HOSTNAME%%.*}\033\\"'
		;;
esac
