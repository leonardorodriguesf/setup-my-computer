#!/usr/bin/env bash

function install_package_manager() {
  if ! command -v brew > /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else 
    echo "Package manager already installed. Skipping..."
  fi
}

function install_automation_engine() {
  if ! command -v ansible > /dev/null; then
    brew install ansible
  else
    echo "Automation engine already installed. Skipping..."
  fi
}

install_package_manager
install_automation_engine
