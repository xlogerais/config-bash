#!/bin/bash

cd $HOME || exit 1

CONFDIR=.bash

ln -sf $CONFDIR/bash_profile .bash_profile
ln -sf $CONFDIR/bashrc .bashrc
ln -sf $CONFDIR/bash_logout .bash_logout

ln -sf $CONFDIR/inputrc .inputrc
