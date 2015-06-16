#!/bin/sh

PYTHON=`which python`

WHOAMI=`${PYTHON} -c 'import os, sys; print os.path.realpath(sys.argv[1])' $0`
UBUNTU=`dirname ${WHOAMI}`
PROJECT=`dirname ${UBUNTU}`

sudo apt-get update
sudo apt-get upgrade

sudo apt-get install apache2 mysql-server memcache
sudo apt-get install php5 php5-cli php5-curl php5-mcrypt php5-memcache php5-mysql

sudo chgrp -R www-data ${PROJECT}/www/templates_c
sudo chmod -R g+ws ${PROJECT}/www/templates_c

{$PROJECT}/ubuntu/setup-apache.sh
{$PROJECT}/ubuntu/setup-php.sh

{$PROJECT}/ubuntu/setup-secrets-base.sh
{$PROJECT}/ubuntu/setup-secrets-crypto.sh

# sudo prompt me...
# {$PROJECT}/ubuntu/setup-mysql.sh

{$PROJECT}/ubuntu/setup-db.sh

exit 0
