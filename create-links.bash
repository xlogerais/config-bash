#!/bin/bash

# Define the path to the directory of this file if not already set
if [ -z "${BASH_CONFIG_DIR}" ]; then
  BASH_CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
fi

cd "${HOME}" || exit 1

ln -sf "${BASH_CONFIG_DIR}"/bash_profile .bash_profile
ln -sf "${BASH_CONFIG_DIR}"/bashrc .bashrc
ln -sf "${BASH_CONFIG_DIR}"/bash_logout .bash_logout
ln -sf "${BASH_CONFIG_DIR}"/inputrc .inputrc
