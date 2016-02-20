#!/bin/bash - 
#===============================================================================
#
#          FILE: provision_db.sh
# 
#         USAGE: ./provision_db.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Fran Rodriguez
#  ORGANIZATION: 
#       CREATED: 18/02/2016 13:55
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

sudo apt-get -y -qqq install postgresql-9.4 >&/dev/null
sudo cp /vagrant/config/db/* /etc/postgresql/9.4/main
sudo service postgresql restart
