#!/bin/sh

PYTHON=`which python`
PERL=`which perl`
PHP=`which php`

WHOAMI=`${PYTHON} -c 'import os, sys; print os.path.realpath(sys.argv[1])' $0`
WHEREAMI=`dirname $WHOAMI`

PROJECT=`dirname $WHEREAMI`
SECRETS="${PROJECT}/www/include/secrets.php"

touch ${SECRETS}

echo "<?php " >> ${SECRETS}
echo "	$GLOBALS['cfg']['crypto_cookie_secret'] = '';" >> ${SECRETS}
echo "	$GLOBALS['cfg']['crypto_password_secret'] = '';" >> {$SECRETS}
echo "	$GLOBALS['cfg']['crypto_crumb_secret'] = '';" >> ${SECRETS}
echo "	$GLOBALS['cfg']['db_main']['pass'] = '';" >> ${SECRETS}
echo ""

exit 0
