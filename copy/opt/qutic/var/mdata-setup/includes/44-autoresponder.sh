if mdata-get mail_smarthost 1>/dev/null 2>&1; then
  MAIL_HOST=`mdata-get mail_smarthost`
  sed -i "s/mail.example.com/${MAIL_HOST}/" /opt/local/var/vmail/.env
  
  if mdata-get mail_auth_user 1>/dev/null 2>&1; then
    MAIL_USER=`mdata-get mail_auth_user`
    sed -i "s/noreply@example.com/${MAIL_USER}/" /opt/local/var/vmail/.env
  end
  
  if mdata-get mail_auth_pass 1>/dev/null 2>&1; then
    MAIL_PASSWORD=`mdata-get mail_auth_pass`
    sed -i "s/pwd/user=${MAIL_PASSWORD}/" /opt/local/var/vmail/.env
  end
  
  if mdata-get postfix_mysqluser 1>/dev/null 2>&1; then
    MYSQLUSER=`mdata-get postfix_mysqluser`
    sed -i "s/user/$MYSQLUSER/" /opt/local/var/vmail/.env
  fi

  if mdata-get postfix_mysqlpassword 1>/dev/null 2>&1; then
    MYSQLPWD=`mdata-get postfix_mysqlpassword`
    sed -i "s/secret/$MYSQLPWD/" /opt/local/var/vmail/.env
  fi

  if mdata-get postfix_mysqldbname 1>/dev/null 2>&1; then
    MYSQDB=`mdata-get postfix_mysqldbname`
    sed -i "s/postfix/$MYSQDB/" /opt/local/var/vmail/.env
  fi
  
  sed -i "s/REDIS_DB=\"1\"/REDIS_DB=\"10\"/" /opt/local/var/vmail/.env
  
  # setup cron
  CRON='0,5,10,15,20,25,30,35,40,45,50,55 * * * * sudo -u vmail /var/lib/vmail/autoresponder 1>>/var/log/autoresponder.log'
  (crontab -l 2>/dev/null || true; echo "$CRON" ) | sort | uniq | crontab
fi
