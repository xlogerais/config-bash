# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]]; then
	# Shell is non-interactive.  Be done now!
	return
fi

# DEBUG_BASHRC=true

# Determine path to directory of this file (FIX: remove dependency to readlink for posix compliance)
BASEDIR=$(
	source_file=$(readlink -f "${BASH_SOURCE[0]}")
	source_dir=$(dirname "${source_file}")
	cd "${source_dir}" && pwd
)

# Source some helpers functions
source "${BASEDIR}/_helpers.bash"

# Source custom libs
_source_dir_files "${BASEDIR}"/libs

# Source 3rd party libs if they exists
_source_file_if_exists "${BASEDIR}/3rd-party/complete-alias/complete_alias"
# _source_file_if_exists "${BASEDIR}/3rd-party/z/z.sh" # FIX: Problème de gestion de la variable PROMPT_COMMAND

# Early customization
_source_dir_files "${BASEDIR}"/rc.before.d

# Source rc.d/*
_source_dir_files "${BASEDIR}"/rc
_source_dir_files "${BASEDIR}"/rc.d

# Source alias definitions
_source_file_if_exists ~/.bash_aliases
_source_file_if_exists "${BASEDIR}"/aliases
_source_dir_files "${BASEDIR}"/aliases
_source_dir_files "${BASEDIR}"/aliases.d

# Source bash completion definitions
# TODO: Améliorer cette partie pour éviter les erreurs quand aucun fichier n'existe
for file in /etc/bash*completion /etc/profile.d/bash*completion*; do source "$file"; done

_source_file_if_exists ~/.bash_completion
_source_file_if_exists "${BASEDIR}"/completion
_source_dir_files "${BASEDIR}"/completion
_source_dir_files "${BASEDIR}"/completion.d
_source_dir_files ~/.nix-profile/share/bash-completion/completions

if (command -v _complete_alias &>/dev/null); then
	for alias in $(alias -p | awk '{print $2}' | awk -F= '{print $1}'); do complete -o default -F _complete_alias "$alias"; done
fi

# Late customization
_source_dir_files "${BASEDIR}"/rc.after.d
