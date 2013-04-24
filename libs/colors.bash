#!/bin/bash

#ANSI CODES
#Code	Effect
#0	All attributes off
#1	Bold
#2	Faint
#3	Italic
#4      Underline
#5	Blink
#6	Rapid blink
#7	Reverse video
#8	Concealed
#30	Black foreground
#31	Red foreground
#32	Green foreground
#33	Yellow foreground
#34	Blue foreground
#35	Magenta foreground
#36	Cyan foreground
#37	White foreground
#40	Black background
#41	Red background
#42	Green background
#43	Yellow background
#44	Blue background
#45	Magenta background
#46	Cyan background
#47	White background
#48	Subscript
#49	Superscript

#T_ROWS=`tput lines`        #  Define current terminal dimension 
#T_COLS=`tput cols`         #+ in rows and columns.
#_UNDERLINE_ON=`tput smul`   # turn on underline
#_UNDERLINE_OFF=`tput rmul`  # turn off underline
#tput setf 4	# tput setf {fg color number}
#tput setb 2	# tput setb {bg color number}

#tput bold - Bold effect
#tput tsmi - Italic
#tput rev - Display inverse colors
#tput sgr0 - Reset everything

default='\E[39;49;00m'
bold='\E[1m'
italic='\E[3m'
underline='\E[4m'
blink='\E[5m'

blackonwhite='\E[30;47m'

#reset=`escape 0m`
#black='\E[30;47m'
#red='\E[31;47m'
#green='\E[32;47m'
#yellow='\E[33;47m'
#blue='\E[34;47m'
#magenta='\E[35;47m'
#cyan='\E[36;47m'
#white='\E[37;47m'
#bold_on=`escape 1m`
#bold_off=`escape 22m`
#blink_on=`escape 5m`
#blink_off=`escape 25m`


function echo_reverse
{
  echo -ne $blackonwhite
  echo -ne "$*"
  echo -e $default
}

function echo_italic
{
  echo -ne $italic
  echo -ne "$*"
  echo -e $default
}

function echo_bold
{
  echo -ne $bold
  echo -ne "$*"
  echo -e $default
}

function echo_underline
{
  echo -ne $underline
  echo -ne "$*"
  echo -e $default
}
