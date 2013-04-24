#!/bin/bash
function urxvt_set_font
{
	printf '\33]50;%s\007' "xft:$1"
}

function urxvt_set_title
{
          # set window title
          printf '\33]2;%s\007' "$1"
}
