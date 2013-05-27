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
    echo '[agent]' >> /etc/puppet/puppet.conf
    echo 'classfile       = $vardir/classes.txt' >> /etc/puppet/puppet.conf
    echo 'localconfig     = $vardir/localconfig' >> /etc/puppet/puppet.conf
    echo 'report          = true' >> /etc/puppet/puppet.conf
    echo 'pluginsync      = true' >> /etc/puppet/puppet.conf
    echo 'masterport      = 8140' >> /etc/puppet/puppet.conf
    echo 'environment     = production' >> /etc/puppet/puppet.conf
    echo 'server          = kalabox.kalamuna.com' >> /etc/puppet/puppet.conf
    echo 'listen          = false' >> /etc/puppet/puppet.conf
    service puppet restart -y
  fi
fi
