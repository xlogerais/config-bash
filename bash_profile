#!/bin/bash

if [ -f $HOME/.bash/profile ]; then source $HOME/.bash/profile; fi
if [ -d $HOME/.bash/profile ]; then for file in $(ls $HOME/.bash/profile/*); do source $file; done; fi
if [ -d $HOME/.bash/profile.d ]; then for file in $(ls $HOME/.bash/profile.d/*); do source $file; done; fi

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
[[ -f ~/.bashrc ]] && . ~/.bashrc
