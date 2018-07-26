if mdata-get postfix_mysqluser 1>/dev/null 2>&1; then
  MYSQLUSER=`mdata-get postfix_mysqluser`
  sed -i "s/=postfix_mysqluser/=$MYSQLUSER/" /opt/local/etc/postfix/sql/mysql_sender_login_maps
  sed -i "s/=postfix_mysqluser/=$MYSQLUSER/" /opt/local/etc/postfix/sql/mysql_virtual_alias_maps
  sed -i "s/=postfix_mysqluser/=$MYSQLUSER/" /opt/local/etc/postfix/sql/mysql_virtual_mailbox_domains
  sed -i "s/=postfix_mysqluser/=$MYSQLUSER/" /opt/local/etc/postfix/sql/mysql_virtual_mailbox_maps
fi

if mdata-get postfix_mysqlpassword 1>/dev/null 2>&1; then
  MYSQLPWD=`mdata-get postfix_mysqlpassword`
  sed -i "s/=postfix_mysqlpassword/=$MYSQLPWD/" /opt/local/etc/postfix/sql/mysql_sender_login_maps
  sed -i "s/=postfix_mysqlpassword/=$MYSQLPWD/" /opt/local/etc/postfix/sql/mysql_virtual_alias_maps
  sed -i "s/=postfix_mysqlpassword/=$MYSQLPWD/" /opt/local/etc/postfix/sql/mysql_virtual_mailbox_domains
  sed -i "s/=postfix_mysqlpassword/=$MYSQLPWD/" /opt/local/etc/postfix/sql/mysql_virtual_mailbox_maps
fi

if mdata-get postfix_mysqldbname 1>/dev/null 2>&1; then
  MYSQDB=`mdata-get postfix_mysqldbname`
  sed -i "s/=postfix_mysqldbname/=$MYSQDB/" /opt/local/etc/postfix/sql/mysql_sender_login_maps
  sed -i "s/=postfix_mysqldbname/=$MYSQDB/" /opt/local/etc/postfix/sql/mysql_virtual_alias_maps
  sed -i "s/=postfix_mysqldbname/=$MYSQDB/" /opt/local/etc/postfix/sql/mysql_virtual_mailbox_domains
  sed -i "s/=postfix_mysqldbname/=$MYSQDB/" /opt/local/etc/postfix/sql/mysql_virtual_mailbox_maps
fi

svcadm enable postfix
