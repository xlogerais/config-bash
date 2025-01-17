#!/bin/bash

_path_add() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

# Source : https://superuser.com/questions/39751/add-directory-to-path-if-its-not-already-there
