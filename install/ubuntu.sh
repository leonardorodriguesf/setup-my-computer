
#!/usr/bin/env bash

set -e

if [ "$(id -u)" -eq 0 ]; then
  SUDO=""
else
  SUDO="sudo"
fi

$SUDO apt update -y
$SUDO apt install software-properties-common
$SUDO add-apt-repository --yes --update ppa:ansible/ansible
$SUDO apt install ansible
