#!/usr/bin/env bash

set -e

if command -v ansible > /dev/null; then
  echo "ansible already installed." 
else
  brew install ansible
fi

ansible-playbook "$SETUP_FOLDER/install/macos.yaml" --tags 1password
ansible-playbook "$SETUP_FOLDER/install/macos.yaml" --skip-tags 1password --ask-vault-password
