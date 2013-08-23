#!/usr/bin/env sh
# Args: `$1`: either `certified-asterisk` (default) or `asterisk`.
# Args: `$2`: asterisk base version number. Example: 1.8.15 (default)
# Have a look at http://www.asterisk.org/downloads/asterisk/all-asterisk-versions

AST_DIST=${1:-"certified-asterisk"} 
AST_VERS=${2:-"1.8.15"} 

sudo apt-get update
sudo apt-get install -y wget aptitude
wget http://downloads.asterisk.org/pub/telephony/$AST_DIST/$AST_DIST-$AST_VERS-current.tar.gz
tar -zxvf $AST_DIST-$AST_VERS-current.tar.gz
rm $AST_DIST-$AST_VERS-current.tar.gz
cd $AST_DIST-$AST_VERS-*
sudo ./contrib/scripts/install_prereq install
sudo ./configure
sudo make
sudo make install
sudo make samples
