#!/usr/bin/env bash

set -e

if command -v ansible > /dev/null; then
  echo "ansible already installed." 
else
  brew install ansible
fi

ansible-playbook "$SETUP_FOLDER/install/macos.yaml" --tags 1password
ansible-playbook "$SETUP_FOLDER/install/macos.yaml" --tags ssh,secrets --ask-vault-password
ansible-playbook "$SETUP_FOLDER/install/macos.yaml" --tags dotfiles

source "$SETUP_FOLDER/dotfiles/install"

ansible-playbook "$SETUP_FOLDER/install/macos.yaml" --skip-tags 1password,ssh,secrets,dotfiles

exec $SHELL