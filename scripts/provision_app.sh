#!/bin/bash - 
#===============================================================================
#
#          FILE: provision_app.sh
# 
#         USAGE: ./provision_app.sh 
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

#set -o nounset                              # Treat unset variables as an error

APP_PATH=/var/www/deployed/hello

sudo apt-get -y -qqq install  postgresql-client-9.4  libpq-dev postgresql-common nodejs ruby-pg  >&/dev/null
gpg --list-keys | grep -q D39DC0E3
if [ $? -eq 1 ]; then
    \curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
fi

if [ ! -e $HOME/.rvm/bin/rvm ]; then
    \curl -sSL https://get.rvm.io | bash -s stable >&/dev/null
    source $HOME/.rvm/scripts/rvm
    rvm  use --default --install 2.1.1 >&/dev/null 
    gem install rails bundle pg >&/dev/null
fi

cd $APP_PATH; bundle install; rake db:create; rake db:migrate; rake db:setup 
if [ ! -e $APP_PATH/tmp ]; then
    cd $APP_PATH; rails server -d -b 0.0.0.0 -e development 
fi
