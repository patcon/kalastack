#!/usr/bin/env bash

if [ ! -f /etc/kalabox/uuid ]; then
  mkdir /etc/kalabox
  uuidgen > /etc/kalabox/uuid
  export KALAUUID=$(cat /etc/kalabox/uuid)
  apt-get update -y
  sudo echo '127.0.1.1       kala.'$KALAUUID'.box' >> /etc/hosts
  sudo hostname kala.$KALAUUID.box
  sudo echo 'kala.'$KALAUUID'.box' >> /etc/hostname
  apt-get install puppet -y
  if grep --quiet certname /etc/puppet/puppet.conf; then
    echo
  else
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
fi
