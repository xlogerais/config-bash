#!/bin/bash
URXVT_FONT_NAME="DejaVu Sans Mono"
URXVT_FONT_SIZE=10
URXVT_FONT_INCREMENT=1

function urxvt_set_font
{
        # set font
	printf '\33]50;%s\007' "xft:$1"
}

function urxvt_set_title
{
          # set window title
          printf '\33]2;%s\007' "$1"
}

# Quick functions

zp() {
	URXVT_FONT_SIZE=$(echo "$URXVT_FONT_SIZE+$URXVT_FONT_INCREMENT" | bc )
	urxvt_set_font "${URXVT_FONT_NAME}:size=${URXVT_FONT_SIZE}"
}

zm() {
	URXVT_FONT_SIZE=$(echo "$URXVT_FONT_SIZE-$URXVT_FONT_INCREMENT" | bc )
	urxvt_set_font "${URXVT_FONT_NAME}:size=${URXVT_FONT_SIZE}"
}
