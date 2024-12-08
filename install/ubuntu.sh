#!/usr/bin/env bash

set -e

if [ "$(id -u)" -eq 0 ]; then
  SUDO=""
else
  SUDO="sudo"
fi

if command -v ansible > /dev/null; then
  echo "ansible already installed." 
else
  $SUDO apt update -y
  $SUDO apt install software-properties-common
  $SUDO add-apt-repository --yes --update ppa:ansible/ansible
  $SUDO apt install ansible
fi


ansible-playbook "$SETUP_FOLDER/install/ubuntu.yaml" --tags 1password
ansible-playbook "$SETUP_FOLDER/install/ubuntu.yaml" --skip-tags 1password --ask-vault-password
