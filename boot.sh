#!/usr/bin/env bash

set -e

dependencies=("git" "python3")

function detect_linux_distro() {
  if [ ! -f /etc/os-release ]; then
    echo "Error: Unable to determine OS. /etc/os-release file not found."
    echo "Installation stopped."
    exit 1
  fi

  . /etc/os-release

  if [ "$ID" != "ubuntu" ]; then
    echo "Error: OS requirement not met"
    echo "You are currently running: $ID $VERSION_ID"
    echo "OS required: Ubuntu"
    echo "Installation stopped."
    exit 1
  fi

  echo "ubuntu"
}

function clone_setup_repo() {  
  setup_folder="$HOME/.local/share/setup-my-computer"
  echo "Cloning setup-my-computer..."
  rm -rf "$setup_folder"
  git clone https://github.com/leonardorodriguesf/setup-my-computer.git "$setup_folder"
}

function install_macos() {
  if command -v brew > /dev/null; then
    echo "Homebrew is already installed."
  else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  for dependency in "${dependencies[@]}"; do
    if command -v "$dependency" &>/dev/null; then
        echo "$dependency is already installed"
    else
        echo "Installing $dependency..."
        brew install "$dependency"
    fi
  done

  clone_setup_repo
}

function install_ubuntu() { 
  if [ "$(id -u)" -eq 0 ]; then
    SUDO=""
  else
    SUDO="sudo"
  fi

  $SUDO apt update -y

  for dependency in "${dependencies[@]}"; do
    if command -v "$dependency" &>/dev/null; then
        echo "$dependency is already installed"
    else
        echo "Installing $dependency..."
        DEBIAN_FRONTEND=noninteractive $SUDO apt install -y "$dependency"
    fi
  done

  clone_setup_repo
}

echo "Checking platform..."
platform="$(uname -s | tr '[:upper:]' '[:lower:]')"

if [[ "$platform" = "linux" ]]; then
  platform="$(detect_linux_distro)"
fi

echo "Installation starting..."
case "${platform}" in
  ubuntu)
    install_ubuntu
  ;;
  darwin)
    install_macos
  ;;
  *)
    echo "Platform not supported."
    echo "Installation stopped."
    exit 1
esac

