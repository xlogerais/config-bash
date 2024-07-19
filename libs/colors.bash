#!/bin/bash

#ANSI CODES
#Code Effect
#0    All attributes off
#1    Bold
#2    Faint
#3    Italic
#4    Underline
#5    Blink
#6    Rapid blink
#7    Reverse video
#8    Concealed
#30   Black foreground
#31   Red foreground
#32   Green foreground
#33   Yellow foreground
#34   Blue foreground
#35   Magenta foreground
#36   Cyan foreground
#37   White foreground
#40   Black background
#41   Red background
#42   Green background
#43   Yellow background
#44   Blue background
#45   Magenta background
#46   Cyan background
#47   White background
#48   Subscript
#49   Superscript

#bold_on=`escape 1m`
#bold_off=`escape 22m`
#blink_on=`escape 5m`
#blink_off=`escape 25m`
#reset=`escape 0m`

#T_ROWS=`tput lines`        #  Define current terminal dimension
#T_COLS=`tput cols`         #+ in rows and columns.
#_UNDERLINE_ON=`tput smul`   # turn on underline
#_UNDERLINE_OFF=`tput rmul`  # turn off underline
#tput setf 4  # tput setf {fg color number}
#tput setb 2  # tput setb {bg color number}

#tput bold - Bold effect
#tput tsmi - Italic
#tput rev - Display inverse colors
#tput sgr0 - Reset everything

# Affiche un message stylisé sur la sortie standard
function echo_bold { echo -e "\e[1m${*}\e[0m"; }
function echo_faint { echo -e "\e[2m${*}\e[0m"; }
function echo_italic { echo -e "\e[3m${*}\e[0m"; }
function echo_underline { echo -e "\e[4m${*}\e[0m"; }
function echo_blink { echo -e "\e[5m${*}\e[0m"; }
function echo_reverse { echo -e "\e[7m${*}\e[0m"; }
function echo_concealed { echo -e "\e[8m${*}\e[0m"; }

# Affiche un message informatif stylisé sur la sortie d'erreur
function echo_info { >&2 echo -e "\e[00;34;49m󰋼  ${*}\e[39;49;00m"; }
function echo_warning { >&2 echo -e "\e[00;33;49m  ${*}\e[39;49;00m"; }
function echo_error { >&2 echo -e "\e[00;01;31;49m  ${*}\e[39;49;00m"; }
function echo_success { >&2 echo -e "\e[00;01;32;49m  ${*}\e[39;49;00m"; }
function echo_failed { >&2 echo -e "\e[00;01;31;49m✖  ${*}\e[39;49;00m"; }

function echo_demo {
  echo_bold bold
  echo_faint faint
  echo_italic italic
  echo_underline underline
  echo_blink blink
  echo_reverse reverse
  echo_concealed concealed
  echo_info info
  echo_warning warning
  echo_error error
  echo_success success
  echo_failed failed
}
