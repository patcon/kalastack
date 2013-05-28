#!/usr/bin/env bash

if [ ! -f /etc/puppet/puppet.conf ]; then
  echo "Installing puppet-common..."
  sudo apt-get update --quiet=2 --yes
  sudo apt-get install puppet-common --quiet=2 --yes
fi
