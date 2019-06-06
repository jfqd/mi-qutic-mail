if mdata-get postfix_postmaster 1>/dev/null 2>&1; then
  DOMAIN=`mdata-get postfix_postmaster | awk -F @ {'print$2'}`
  sed -i \
      "s/$mydomain = 'example.com'/$mydomain = '${DOMAIN}'/" \
      /opt/local/etc/amavisd.conf
fi

if mdata-get postfix_mynetworks 1>/dev/null 2>&1; then
  MYNETWORK_LIST=`mdata-get postfix_mynetworks | sed  's/,/ /g'`
  sed -i \
      "s/@mynetworks = qw( 127.0.0.0/8 192.168.0.0/16 );/@mynetworks = qw( ${MYNETWORK_LIST} );/" \
      /opt/local/etc/amavisd.conf
fi

if mdata-get postfix_mynetworks 1>/dev/null 2>&1; then
  MYNETWORK=`mdata-get postfix_mynetworks`
  sed -i \
      "s/# trusted_networks 212.17.35./trusted_networks ${MYNETWORK}/" \
      /opt/local/etc/spamassassin/local.cf
fi

if mdata-get postfix_mysqlpassword 1>/dev/null 2>&1; then
  MYSQLPWD=`mdata-get postfix_mysqlpassword`
  sed -i \
      "s/bayes_sql_password <sa_password>/bayes_sql_password ${MYSQLPWD}/" \
      /opt/local/etc/spamassassin/local.cf
fi

if mdata-get postfix_mysqluser 1>/dev/null 2>&1 && mdata-get postfix_mysqlpassword 1>/dev/null 2>&1 && mdata-get postfix_mysqldbname 1>/dev/null 2>&1; then
  MYSQLUSER=`mdata-get postfix_mysqluser`
  MYSQLPWD=`mdata-get postfix_mysqlpassword`
  MYSQDB=`mdata-get postfix_mysqldbname`

  sed -i \
      "s/dbi:mysql:database=postfix;host=127.0.0.1:3306;user=postfix;password=passwort/dbi:mysql:database=${MYSQDB};host=127.0.0.1:3306;user=${MYSQLUSER};password=${MYSQLPWD}/" \
      /opt/local/bin/create-local-domains-maps

  chmod 0700 /opt/local/bin/create-local-domains-maps
  CRON='0 * * * * /opt/local/bin/create-local-domains-maps'
  (crontab -l 2>/dev/null || true; echo "$CRON" ) | sort | uniq | crontab
fi