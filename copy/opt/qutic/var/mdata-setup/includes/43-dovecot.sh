if mdata-get postfix_mysqluser 1>/dev/null 2>&1; then
  MYSQLUSER=`mdata-get postfix_mysqluser`
  sed -i "s/user=postfix_mysqluser/user=$MYSQLUSER/" /opt/local/etc/dovecot/dovecot-sql.conf
fi

if mdata-get postfix_mysqlpassword 1>/dev/null 2>&1; then
  MYSQLPWD=`mdata-get postfix_mysqlpassword`
  sed -i "s/password=postfix_mysqlpassword/password=$MYSQLPWD/" /opt/local/etc/dovecot/dovecot-sql.conf
fi

if mdata-get postfix_mysqldbname 1>/dev/null 2>&1; then
  MYSQDB=`mdata-get postfix_mysqldbname`
  sed -i "s/dbname=postfix_mysqldbname/dbname=$MYSQDB/" /opt/local/etc/dovecot/dovecot-sql.conf
fi

if mdata-get postfix_pwd_salt 1>/dev/null 2>&1; then
  SALT=`mdata-get postfix_pwd_salt`
  sed -i "s/postfix_pwd_salt/$SALT/" /opt/local/etc/dovecot/dovecot-sql.conf
fi

if mdata-get postfix_postmaster 1>/dev/null 2>&1; then
  POSTMASTER=`mdata-get postfix_postmaster`
  sed -i "s/postmaster@example.com/$POSTMASTER/" /opt/local/etc/dovecot/dovecot.conf
fi

svcadm enable svc:/pkgsrc/dovecot:default
