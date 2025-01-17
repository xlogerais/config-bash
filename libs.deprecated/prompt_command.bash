#!/bin/bash

_prompt_command_add() {
    if [ -n "$1" ] && [[ ":$PROMPT_COMMAND:" != *":$1:"* ]]; then
        PROMPT_COMMAND="${PROMPT_COMMAND:+"$PROMPT_COMMAND;"}$1"
    fi
}

export PROMPT_COMMAND
