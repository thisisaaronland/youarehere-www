#!/bin/sh

PYTHON=`which python`
PERL=`which perl`

WHOAMI=`${PYTHON} -c 'import os, sys; print os.path.realpath(sys.argv[1])' $0`
UBUNTU=`dirname ${WHOAMI}`
ROOT=`dirname ${UBUNTU}`

if [ ! -e /etc/php5/apache2/conf.d/10-mcrypt.ini ]
then
    sudo ln -s /etc/php5/mods-available/mcrypt.ini /etc/php5/apache2/conf.d/10-mcrypt.ini
fi 

if [ ! -e /etc/php5/cli/conf.d/10-mcrypt.ini ]
then
    sudo ln -s /etc/php5/mods-available/mcrypt.ini /etc/php5/cli/conf.d/10-mcrypt.ini
fi 

sudo ${PERL} -pi -e 's/short_open_tag = Off/short_open_tag = On/' /etc/php5/cli/php.ini

sudo /etc/init.d/apache2 restart
