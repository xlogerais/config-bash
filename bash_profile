#!/bin/bash

if [ -f "${HOME}"/.nix-profile/etc/profile.d/hm-session-vars.sh ]; then
	source "${HOME}"/.nix-profile/etc/profile.d/hm-session-vars.sh
fi

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

_source_file_if_exists "${BASH_CONFIG_DIR}/profile"
_source_dir_files "${BASH_CONFIG_DIR}/profile"
_source_dir_files "${BASH_CONFIG_DIR}/profile.d"

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
[[ -f ~/.bashrc ]] && . ~/.bashrc
