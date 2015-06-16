#!/bin/sh

PYTHON=`which python`
PERL=`which perl`
PHP=`which php`

WHOAMI=`${PYTHON} -c 'import os, sys; print os.path.realpath(sys.argv[1])' $0`

WHEREAMI=`dirname $WHOAMI`
PROJECT=`dirname $WHEREAMI`

SECRETS="${PROJECT}www/include/secrets.php"

MYSQL=`which mysql`

DBNAME='youarehere'
USERNAME='youarehere'
PASSWORD=`${PHP} ${ROOT}/bin/generate_secret.php`

echo "CREATE DATABASE ${DBNAME};" > /tmp/${DBNAME}.sql
echo "CREATE user '${USERNAME}'@'localhost' IDENTIFIED BY '${PASSWORD}';" >> /tmp/${DBNAME}.sql
echo "GRANT SELECT,UPDATE,DELETE,INSERT ON ${DBNAME}.* TO '${USERNAME}'@'localhost' IDENTIFIED BY '${PASSWORD}';" >> /tmp/${DBNAME}.sql
echo "FLUSH PRIVILEGES;" >> /tmp/${DBNAME}.sql

echo "USE ${DBNAME};" >> /tmp/${DBNAME}.sql;

for f in `ls -a ${ROOT}/schema/*.schema`
do
	echo "" >> /tmp/${DBNAME}.sql
	cat $f >> /tmp/${DBNAME}.sql
done

mysql -u root -p < /tmp/${DBNAME}.sql

unlink /tmp/${DBNAME}.sql

${PERL} -pi -e "s!$GLOBALS['cfg']['db_main']['pass'] = ''!$GLOBALS['cfg']['db_main']['pass'] = '${PASSWORD}'!" ${SECRETS}
