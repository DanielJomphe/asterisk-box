#!/usr/bin/env sh

SECRET_DIR="/vagrant/conf/secret"
if [ -e "$SECRET_DIR/extensions.conf" ]; then
  NOW=$(date +"%Y-%m-%d-%H-%M")
  BACK=backup-$NOW
  cd /etc/asterisk
  # Todo: instead of handling only those 2 files, why not loop through all files present in secret?
  mkdir $BACK
  cp extensions.conf $BACK
  cp sip.conf $BACK
  cp $SECRET_DIR/extensions.conf .
  cp $SECRET_DIR/sip.conf .
fi
