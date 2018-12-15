if mdata-get postfix_postmaster 1>/dev/null 2>&1; then
  DOMAIN=`mdata-get postfix_postmaster | awk -F @ {'print$2'}`
  sed -i "s/$mydomain = 'example.com'/$mydomain = '${DOMAIN}'/" /opt/local/etc/amavisd.conf
fi

if mdata-get postfix_mysqlpassword 1>/dev/null 2>&1; then
  MYSQLPWD=`mdata-get postfix_mysqlpassword`
  sed -i "s/bayes_sql_password <sa_password>/bayes_sql_password ${MYSQLPWD}/" /opt/local/etc/spamassassin/local.cf
fi
