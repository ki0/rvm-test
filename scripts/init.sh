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
#        AUTHOR: Fran Rodriguez
#  ORGANIZATION: 
#       CREATED: 19/02/2016 19:59
#      REVISION:  ---
#===============================================================================

#set -o nounset                              # Treat unset variables as an error

sudo apt-get -y -qqq install  postgresql-client-9.4  libpq-dev postgresql-common ruby-pg 
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 
\curl -sSL https://get.rvm.io | bash -s stable 
source $HOME/.rvm/scripts/rvm
rvm  use --default --install 2.1.1 >&/dev/null 
gem install bundle rails pg
mkdir -p deployed ; cd deployed ; rails new hello --database=postgresql 
