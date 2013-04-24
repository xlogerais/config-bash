#!/bin/bash

# GNU Screen stuff
if ( which screen &> /dev/null )
then
  if [[ $TERM != screen* ]]
  then
    if [ "$(screen -ls | sed -ne 's/[[:space:]]//' -ne 's/(Attached)// p')" ]
    then
      echo ''
      echo_reverse 'Il existe des sessions screen attachées sur cette machine pour cet utilisateur !'
      echo ''
      screen -ls | grep "Attached" | sed -e 's/^/          /'
      echo ''
    fi
    if [ "$(screen -ls | sed -ne 's/[[:space:]]//' -ne 's/(Detached)// p')" ]
    then
      echo ''
      echo_reverse "Il existe des sessions screen détachées sur cette machine pour cet utilisateur !"
      echo ''
      screen -ls | grep "Detached" | sed -e 's/^/          /'
      echo ''
    fi
  fi
fi

