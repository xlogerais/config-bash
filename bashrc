# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]]; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Safe loops for empty dirs
shopt -s nullglob

# Source custom libs
if [ -d "$HOME"/.bash/libs ]; then for lib in "$HOME"/.bash/libs/*.bash; do source "$lib"; done; fi

# Early customization
if [ -d "$HOME"/.bash/rc.before.d ]; then for file in "$HOME"/.bash/rc.before.d/*; do source "$file"; done; fi

# Source rc.d/*
if [ -d "$HOME"/.bash/rc.d ]; then for file in "$HOME"/.bash/rc.d/*; do source "$file"; done; fi

# Source alias definitions
if [ -f "$HOME"/.bash_aliases ]; then source "$HOME"/.bash_aliases; fi
if [ -f "$HOME"/.bash/aliases ]; then source "$HOME"/.bash/aliases; fi
if [ -d "$HOME"/.bash/aliases ]; then for file in "$HOME"/.bash/aliases/*; do source "$file"; done; fi
if [ -d "$HOME"/.bash/aliases.d ]; then for file in "$HOME"/.bash/aliases.d/*; do source "$file"; done; fi
if (command -v _complete_alias &>/dev/null); then
	for alias in $(alias -p | awk '{print $2}' | awk -F= '{print $1}'); do complete -o default -F _complete_alias "$alias"; done
fi

# Source bash completion definitions
for file in /etc/bash*completion /etc/profile.d/bash*completion*; do source "$file"; done

if [ -f "$HOME"/.bash_completion ]; then source "$HOME"/.bash_completion; fi
if [ -f "$HOME"/.bash/completion ]; then source "$HOME"/.bash/completion; fi
if [ -d "$HOME"/.bash/completion ]; then for file in "$HOME"/.bash/completion/*; do source "$file"; done; fi
if [ -d "$HOME"/.bash/completion.d ]; then for file in "$HOME"/.bash/completion.d/*; do source "$file"; done; fi

# Late customization
if [ -d "$HOME"/.bash/rc.after.d ]; then for file in "$HOME"/.bash/rc.after.d/*; do source "$file"; done; fi

# Restore option nullglob to normal
shopt -u nullglob
