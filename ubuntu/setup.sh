#!/bin/sh

PYTHON=`which python`

WHOAMI=`${PYTHON} -c 'import os, sys; print os.path.realpath(sys.argv[1])' $0`
UBUNTU=`dirname ${WHOAMI}`
ROOT=`dirname ${UBUNTU}`

sudo apt-get update
sudo apt-get upgrade

sudo apt-get install apache2 mysql-server memcache
sudo apt-get install php5 php5-cli php5-curl php5-mcrypt php5-memcache php5-mysql

sudo chgrp -R www-data ${ROOT}/www/templates_c
sudo chmod -R g+ws ${ROOT}/www/templates_c

{$ROOT}/ubuntu/setup-apache.sh
{$ROOT}/ubuntu/setup-php.sh

exit 0
