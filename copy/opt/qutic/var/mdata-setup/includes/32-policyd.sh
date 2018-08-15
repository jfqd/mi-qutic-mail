if mdata-get postfix_mysqluser 1>/dev/null 2>&1; then
  MYSQL_USER=`mdata-get postfix_mysqluser`
  sed -i "s/Username=postfix/Username=${MYSQL_USER}/" /opt/local/etc/cluebringer.conf
fi

if mdata-get postfix_mysqlpassword 1>/dev/null 2>&1; then
  MYSQL_PWD=`mdata-get postfix_mysqlpassword`
  sed -i "s/Password=p0stf1x/Password=${MYSQL_PWD}/" /opt/local/etc/cluebringer.conf
fi

svcadm enable svc:/network/policyd:default

CRON='0 * * * * /opt/local/libexec/cbpadmin --cleanup 1>/dev/null'
(crontab -l 2>/dev/null || true; echo "$CRON" ) | sort | uniq | crontab
