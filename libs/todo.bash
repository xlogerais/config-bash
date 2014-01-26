#!/bin/bash

todo() {
    if [[ ! -f $HOME/.todo ]]; then
        touch $HOME/.todo
    fi

    if [[ $# -eq 0 ]]; then
        cat $HOME/.todo
    elif [[ "$1" == "-l" ]]; then
        cat -n $HOME/.todo
    elif [[ "$1" == "-c" ]]; then
        echo "" > $HOME/.todo
    elif [[ "$1" == "-r" ]]; then
        cat -n $HOME/.todo
        echo -ne "----------------------------\nType a number to remove: "
        read NUMBER
        sed -ie ${NUMBER}d $HOME/.todo
    else
        echo "$@" >> $HOME/.todo
    fi
}
