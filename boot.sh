#!/usr/bin/env bash

set -e

echo "Cloning setup-my-computer..."
setup_folder="$HOME/.local/share/setup-my-computer"
rm -rf "$setup_folder"
git clone https://github.com/leonardorodriguesf/setup-my-computer.git "$setup_folder"

echo "Installation starting..."
source "$setup_folder/install.sh"
