if mdata-get mail_smarthost 1>/dev/null 2>&1; then
  MAIL_HOST=`mdata-get mail_smarthost`
  sed -i "s#MAILSERVER=\"mail.example.com\"#MAILSERVER=\"${MAIL_HOST}\"#" /opt/local/var/vmail/.env
  sed -i "s#MAILBOX_PATH=\"/your/mailbox/path\"#MAILBOX_PATH=\"/var/mail/vhosts\"#" /opt/local/var/vmail/.env
  
  if mdata-get mail_auth_user 1>/dev/null 2>&1; then
    MAIL_USER=`mdata-get mail_auth_user`
    sed -i "s#MAILUSER=\"noreply@example.com\"#MAILUSER=\"${MAIL_USER}\"#" /opt/local/var/vmail/.env
  fi
  
  if mdata-get mail_auth_pass 1>/dev/null 2>&1; then
    MAIL_PASSWORD=`mdata-get mail_auth_pass`
    sed -i "s#MAILPDW=\"pwd\"#MAILPDW=\"${MAIL_PASSWORD}\"#" /opt/local/var/vmail/.env
  fi
  
  if mdata-get postfix_mysqluser 1>/dev/null 2>&1; then
    MYSQL_USER=`mdata-get postfix_mysqluser`
    sed -i "s#MYSQL_USER=\"user\"#MYSQL_USER=\"${MYSQL_USER}\"#" /opt/local/var/vmail/.env
  fi

  if mdata-get postfix_mysqlpassword 1>/dev/null 2>&1; then
    MYSQL_PWD=`mdata-get postfix_mysqlpassword`
    sed -i "s#MYSQL_PWD=\"secret\"#MYSQL_PWD=\"${MYSQL_PWD}\"#" /opt/local/var/vmail/.env
  fi

  if mdata-get postfix_mysqldbname 1>/dev/null 2>&1; then
    MYSQL_DB=`mdata-get postfix_mysqldbname`
    sed -i "s#MYSQL_DATABASE=\"postfix\"#MYSQL_DATABASE=\"${MYSQL_DB}\"#" /opt/local/var/vmail/.env
  fi
  
  sed -i "s#REDIS_DB=\"1\"#REDIS_DB=\"10\"#" /opt/local/var/vmail/.env
  
  if mdata-get autoresponder 1>/dev/null 2>&1; then
    # setup cron
    CRON='0,5,10,15,20,25,30,35,40,45,50,55 * * * * sudo -u vmail /opt/local/var/vmail/autoresponder 1>>/var/log/autoresponder.log'
    (crontab -l 2>/dev/null || true; echo "$CRON" ) | sort | uniq | crontab
    CRON='59 23 * * * sudo -u vmail /opt/qutic/bin/autoresponder-cron'
    (crontab -l 2>/dev/null || true; echo "$CRON" ) | sort | uniq | crontab
  fi
fi
