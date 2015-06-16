#!/bin/sh

PYTHON=`which python`

WHOAMI=`${PYTHON} -c 'import os, sys; print os.path.realpath(sys.argv[1])' $0`
UBUNTU=`dirname ${WHOAMI}`
ROOT=`dirname ${UBUNTU}`

if [ ! -e /etc/apache2/mods-enabled/rewrite.load ]
then
    sudo ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load
fi 

if [ ! -e /etc/apache2/mods-enabled/proxy.load ]
then
    sudo ln -s /etc/apache2/mods-available/proxy.load /etc/apache2/mods-enabled/proxy.load
fi 

if [ ! -e /etc/apache2/mods-enabled/proxy.conf ]
then
    sudo ln -s /etc/apache2/mods-available/proxy.conf /etc/apache2/mods-enabled/proxy.conf
fi

if [ ! -e /etc/apache2/mods-enabled/proxy_http.load ]
then
    sudo ln -s /etc/apache2/mods-available/proxy_http.load /etc/apache2/mods-enabled/proxy_http.load
fi

if [ ! -e /etc/apache2/mods-enabled/ssl.conf ]
then
    sudo ln -s /etc/apache2/mods-available/ssl.conf /etc/apache2/mods-enabled/ssl.conf
fi

if [ ! -e /etc/apache2/mods-enabled/ssl.load ]
then
    sudo ln -s /etc/apache2/mods-available/ssl.load /etc/apache2/mods-enabled/ssl.load
fi

if [ ! -e /etc/apache2/mods-enabled/socache_shmcb.load ]
    sudo ln -s /etc/apache2/mods-available/socache_shmcb.load /etc/apache2/mods-enabled/socache_shmcb.load
fi

sudo /etc/init.d/apache2 restart
