#!/bin/bash

function basedir() {
	(cd "$(dirname \"$-2\")" && pwd)
}

function _source_file_if_exists() {
	if [ -r "$1" ]; then
		test -n "$DEBUG_BASHRC" && echo "-- Sourcing file $1"
		source "$1"
	fi
}

function _source_dir_files() {
	if [ -d "$1" ]; then
		test -n "$DEBUG_BASHRC" && echo "-- Sourcing files in directory $1"

		# Safe loops for empty dirs
		shopt -s nullglob

		for file in "$1"/*; do
			if [ -e "$file" ]; then
				test -n "$DEBUG_BASHRC" && echo "    * sourcing file $file"
				source "$file"
			fi
		done

		# Restore option nullglob to normal
		shopt -u nullglob
	fi
}

# Source : https://superuser.com/questions/39751/add-directory-to-path-if-its-not-already-there
_path_add() {
	if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
		PATH="${PATH:+"$PATH:"}$1"
	fi
}

_prompt_command_add() {
	if [ -n "$1" ] && [[ ":$PROMPT_COMMAND:" != *":$1:"* ]]; then
		PROMPT_COMMAND="${PROMPT_COMMAND:+"$PROMPT_COMMAND;"}$1"
	fi
}
