#!/bin/bash - 
#===============================================================================
#
#          FILE: init.sh
# 
#         USAGE: ./init.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Dr. Fritz Mehner (fgm), mehner.fritz@web.de
#  ORGANIZATION: 
#       CREATED: 19/02/2016 19:59
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 
\curl -sSL https://get.rvm.io | bash -s stable --rails 
rvm --default use 2.1.1 >&/dev/null
sudo apt-get -y -qq install  postgresql-client-9.4  libpq-dev postgresql-common ruby-pg 
mkdir -p deployed ; cd deployed ; rails new hello --database=postgresql 
