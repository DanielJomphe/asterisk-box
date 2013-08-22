#!/usr/bin/env bash
# For now, this script provisions only `certified-asterisk` versions.
# Args: `$1`: asterisk base version number. Example: 1.8.15

sudo apt-get update
sudo apt-get install -y wget aptitude vim
wget http://downloads.asterisk.org/pub/telephony/certified-asterisk/certified-asterisk-$1-current.tar.gz && \
tar -zxvf certified-asterisk-$1-current.tar.gz
rm certified-asterisk-$1-current.tar.gz
cd certified-asterisk-$1-*
sudo ./contrib/scripts/install_prereq install
sudo ./configure
sudo make
sudo make install
sudo make samples


NOW=$(date +"%Y-%m-%d-%H-%M")
BACK=backup-$NOW
cd /etc/asterisk
# Todo: instead of handling only those 2 files, why not loop through all files present in secret?
mkdir $BACK
cp extensions.conf $BACK
cp sip.conf $BACK
cp /vagrant/bootstrap/secret/conf/extensions.conf .
cp /vagrant/bootstrap/secret/conf/sip.conf .