#!/usr/bin/env bash

set -e

export SETUP_FOLDER="$HOME/.local/share/setup-my-computer"

dependencies=("git")
start_new_session=false

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
  cd ~

  echo "Cloning setup-my-computer..."

  rm -rf "$SETUP_FOLDER"

  git clone https://github.com/leonardorodriguesf/setup-my-computer.git "$SETUP_FOLDER"

  cd -
}

function install_macos() {
  sudo echo "Starting macOS installation..."

  if [ -f /opt/homebrew/bin/brew ]; then
    echo "Homebrew is already installed."
  else
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
    start_new_session=true
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

  source "$SETUP_FOLDER/install/macos.sh"
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

  source "$SETUP_FOLDER/install/ubuntu.sh"
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

if [ "$start_new_session" = true ]; then
  exec $SHELL
fi
