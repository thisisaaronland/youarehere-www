#!/bin/sh

PYTHON=`which python`
PERL=`which perl`
PHP=`which php`

WHOAMI=`${PYTHON} -c 'import os, sys; print os.path.realpath(sys.argv[1])' $0`
WHEREAMI=`dirname $WHOAMI`

PROJECT=`dirname $WHEREAMI`
SECRETS="${PROJECT}/www/include/secrets.php"

if [ ! -e ${SECRETS} ]
then
    echo "No secrets file, you need to run ${WHEREAMI}/setup-secrets-base.sh first"
    exit 1
fi

PASSWORD=`${PHP} -q ${PROJECT}/bin/generate_secret.php`
${PERL} -pi -e "s!$GLOBALS['cfg']['crypto_cookie_secret'] = ''!$GLOBALS['crypto_cookie_secret'] = '${PASSWORD}'!" ${SECRETS}

PASSWORD=`${PHP} -q ${PROJECT}/bin/generate_secret.php`
${PERL} -pi -e "s!$GLOBALS['cfg']['crypto_password_secret'] = ''!$GLOBALS['crypto_password_secret'] = '${PASSWORD}'!" ${SECRETS}

PASSWORD=`${PHP} -q ${PROJECT}/bin/generate_secret.php`
${PERL} -pi -e "s!$GLOBALS['cfg']['crypto_crumb_secret'] = ''!$GLOBALS['crypto_crumb_secret'] = '${PASSWORD}'!" ${SECRETS}

exit 0
