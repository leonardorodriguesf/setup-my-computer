#!/usr/bin/env bash

function install_package_manager() {
  if ! command -v brew > /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else 
    echo "Package manager already installed. Skipping..."
  fi
}

install_package_manager
