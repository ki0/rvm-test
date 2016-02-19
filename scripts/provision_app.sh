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
#        AUTHOR: Dr. Fritz Mehner (fgm), mehner.fritz@web.de
#  ORGANIZATION: 
#       CREATED: 18/02/2016 13:55
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 >&/dev/null
\curl -sSL https://get.rvm.io | bash -s stable --rails >&/dev/null
rvm --default use 2.1.1 >&/dev/null
sudo apt-get -y -qq install  postgresql-client-9.4  libpq-dev postgresql-common ruby-pg >&/dev/null
cd /var/www/deployed/hello; rake db:migrate; rake db:setup >&/dev/null
cd /var/www/deployed/hello; bin/rails generate controller welcome >&/dev/null
