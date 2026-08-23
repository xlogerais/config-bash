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


# Define the path to the directory of this file if not already set
if [ -z "${BASH_CONFIG_DIR}" ]; then
  # Define a function to get the real path of a script
  # (works for most cases : either sourced script or executed script, posix shells)
  get_script_dir() {
    local target
    # Si appelé depuis un script (Bash), on regarde qui a appelé la fonction (${BASH_SOURCE[1]})
    # Si la fonction est exécutée directement dans le terminal, on se rabat sur ${BASH_SOURCE[0]} ou ${0}
    if [ -n "${BASH_SOURCE}" ]; then
      if [ "${#BASH_SOURCE[@]}" -gt 1 ]; then
        target="${BASH_SOURCE[1]}"
      else
        target="${BASH_SOURCE[0]}"
      fi
    elif [ -n "${ZSH_VERSION}" ]; then
      target="${(%):-%x}"
    else
      target="${0}"
    fi

    # Résolution des liens symboliques POSIX
    while [ -L "${target}" ]; do
      local link
      link=$(readlink "${target}")
      case "${link}" in
        /*) target="${link}" ;;
        *)  target="$(dirname "${target}")/${link}" ;;
      esac
    done

    (cd "$(dirname "${target}")" && pwd -P)
  }
  BASH_CONFIG_DIR=$(get_script_dir)
fi

# Source some helpers functions
source "${BASH_CONFIG_DIR}/_helpers.bash"

# Source custom libs
_source_dir_files "${BASH_CONFIG_DIR}"/libs

# Source 3rd party libs if they exists
_source_file_if_exists "${BASH_CONFIG_DIR}/3rd-party/complete-alias/complete_alias"
_source_file_if_exists "${BASH_CONFIG_DIR}/3rd-party/junegunn/fzf-git.sh/fzf-git.sh"

# Early customization
_source_dir_files "${BASH_CONFIG_DIR}"/rc.before.d

# Source rc.d/*
_source_dir_files "${BASH_CONFIG_DIR}"/rc
_source_dir_files "${BASH_CONFIG_DIR}"/rc.d

# Source functions definitions
_source_file_if_exists ~/.bash_functions
_source_file_if_exists "${BASH_CONFIG_DIR}"/functions
_source_dir_files "${BASH_CONFIG_DIR}"/functions
_source_dir_files "${BASH_CONFIG_DIR}"/functions.d

# Source alias definitions
_source_file_if_exists ~/.bash_aliases
_source_file_if_exists "${BASH_CONFIG_DIR}"/aliases
_source_dir_files "${BASH_CONFIG_DIR}"/aliases
_source_dir_files "${BASH_CONFIG_DIR}"/aliases.d

# Source bash completion definitions
# System-wide bash completion (bash-completion package) is expected to
# already be wired by the distro itself, typically via
# /etc/profile.d/bash_completion.sh for login shells and the package's
# own non-login hook — no need to re-source it manually here.

# Use bash-completion, if available, and avoid double-sourcing
[[ $PS1 &&
  ! ${BASH_COMPLETION_VERSINFO:-} &&
  -f /usr/share/bash-completion/bash_completion ]] &&
    . /usr/share/bash-completion/bash_completion

# Location for user bash completion
# ${BASH_COMPLETION_USER_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/bash-completion}/completions

# See https://serverfault.com/questions/506612/standard-place-for-user-defined-bash-completion-d-scripts
# Recommended dirs
# - ~/.bash_completion.d ->  ${XDG_DATA_HOME:-$HOME/.local/share}/bash-completion
# - ~/.bash_completion -> ${XDG_CONFIG_HOME:-$HOME/.config}/bash_completion
_source_file_if_exists ~/.bash_completion
_source_file_if_exists "${BASH_CONFIG_DIR}"/completion
_source_dir_files "${BASH_CONFIG_DIR}"/completion
_source_dir_files "${BASH_CONFIG_DIR}"/completion.d
_source_dir_files ~/.nix-profile/share/bash-completion/completions

if (command -v _complete_alias &>/dev/null); then
	for alias in $(alias -p | awk '{print $2}' | awk -F= '{print $1}'); do complete -o default -F _complete_alias "${alias}"; done
fi

# Late customization
_source_dir_files "${BASH_CONFIG_DIR}"/rc.after.d
