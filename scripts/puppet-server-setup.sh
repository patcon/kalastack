#!/usr/bin/env bash

if ! grep --quiet --no-messages certname /etc/puppet/puppet.conf; then
  echo "Installing puppet-server..."
  apt-get update --quiet
  apt-get install puppet --yes

  # Silently append snippet below to puppetconf
  cat << 'EOF' | tee -a /etc/puppet/puppet.conf > /dev/null
[agent]
classfile       = $vardir/classes.txt
localconfig     = $vardir/localconfig
report          = true
pluginsync      = true
masterport      = 8140
environment     = production
server          = kalabox.kalamuna.com
listen          = false
EOF

  service puppet restart -y
fi
