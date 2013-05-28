#!/usr/bin/env bash

if [ ! -f /etc/kalabox/uuid ]; then
  mkdir /etc/kalabox
  export KALAUUID=$(uuidgen)
  echo "Generating kalabox uuid ..."
  echo $KALAUUID > /etc/kalabox/uuid

  # Silently append output to root-owned files.
  echo "Configuring kalabox hostname kala.${KALAUUID}.box ..."
  echo "127.0.1.1 kala.${KALAUUID}.box" | sudo tee -a /etc/hosts    > /dev/null
  echo "kala.${KALAUUID}.box"           | sudo tee -a /etc/hostname > /dev/null
  sudo hostname kala.${KALAUUID}.box
fi
