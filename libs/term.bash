#!/bin/bash

function term_change_title {
	case $TERM in
	# Change the window title of X terminals
	xterm* | rxvt* | urxvt* | Eterm)
		echo -ne "\033]0;${1}\007"
		;;

	# Change the window title of screen terminals
	screen* | tmux*)
		echo -ne "\033k${1}\033\\"
		;;
	esac

}
