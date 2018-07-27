if mdata-get postfix_mysqluser 1>/dev/null 2>&1; then
  MYSQL_USER=`mdata-get postfix_mysqluser`
  sed -i "s/MYSQLUSER=\"postfix\"/MYSQLUSER=\"${MYSQL_USER}\"/" /opt/local/etc/policyd.conf
fi

if mdata-get postfix_mysqlpassword 1>/dev/null 2>&1; then
  MYSQL_PWD=`mdata-get postfix_mysqlpassword`
  sed -i "s/MYSQLPASS=\"p0stf1x\"/MYSQLPASS=\"${MYSQL_PWD}\"/" /opt/local/etc/policyd.conf
fi

svcadm enable svc:/network/policyd:default

CRON='0 * * * * /opt/local/libexec/policyd/cleanup -c /opt/local/etc/policyd.conf'
(crontab -l 2>/dev/null || true; echo "$CRON" ) | sort | uniq | crontab
