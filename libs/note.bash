#!/bin/bash

note() {
    # if file doesn't exist, create it
    if [[ ! -f $HOME/.notes ]]; then
        touch "$HOME"/.notes
    fi

    if [[ $# -eq 0 ]]; then
        # no arguments, print file
        cat "$HOME"/.notes
    elif [[ "$1" == "-c" ]]; then
        # clear file
        echo "" >"$HOME"/.notes
    else
        # add all arguments to file
        echo "$@" >>"$HOME"/.notes
    fi
}
