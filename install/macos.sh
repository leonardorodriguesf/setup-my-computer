#!/usr/bin/env bash

set -e

if command -v ansible > /dev/null; then
  echo "ansible already installed." 
else
  brew install ansible
fi

ansible-playbook -t 1password macos.yaml
