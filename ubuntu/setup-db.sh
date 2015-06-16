#!/bin/sh

PYTHON=`which python`
PERL=`which perl`
PHP=`which php`

WHOAMI=`${PYTHON} -c 'import os, sys; print os.path.realpath(sys.argv[1])' $0`

WHEREAMI=`dirname $WHOAMI`
PROJECT=`dirname $WHEREAMI`

SECRETS="${PROJECT}/www/include/secrets.php"

MYSQL=`which mysql`

DBNAME='youarehere'
USERNAME='youarehere'
PASSWORD=`${PHP} ${PROJECT}/bin/generate_secret.php`

SETUP_FILE="/tmp/${DBNAME}.sql"
TABLES_FILE="/tmp/${DBNAME}-tables.sql"

if [ -f ${SETUP_FILE} ]
then
    rm ${SETUP_FILE}
fi

if [ -f ${TABLES_FILE} ]
then
    rm ${TABLES_FILE}
fi

    
touch ${SETUP_FILE}
touch ${TABLES_FILE}

echo "DROP DATABASE IF EXISTS ${DBNAME};" >> ${SETUP_FILE}
echo "CREATE DATABASE ${DBNAME};" >> ${SETUP_FILE}

echo "DROP user '${USERNAME}'@'localhost';" >> ${SETUP_FILE}
echo "CREATE user '${USERNAME}'@'localhost' IDENTIFIED BY '${PASSWORD}';" >> ${SETUP_FILE}

echo "GRANT SELECT,UPDATE,DELETE,INSERT ON ${DBNAME}.* TO '${USERNAME}'@'localhost' IDENTIFIED BY '${PASSWORD}';" >> ${SETUP_FILE}
echo "FLUSH PRIVILEGES;" >> ${SETUP_FILE}

for f in `ls -a ${PROJECT}/schema/*.schema`
do
	echo "" >> ${TABLES_FILE}
	cat $f >> ${TABLES_FILE}
done

mysql -u root -p mysql < ${SETUP_FILE}
mysql -u root -p ${DBNAME} < ${TABLES_FILE}

rm  ${SETUP_FILE}
rm ${TABLES_FILE}

# FIX ME
# ${PERL} -pi -e "s/\$GLOBALS['cfg']['db_main']['pass'] = ''/\$GLOBALS['cfg']['db_main']['pass'] = '${PASSWORD}'/" ${SECRETS}
