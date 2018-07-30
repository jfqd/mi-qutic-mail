sed -i "s/=postfix_mysqlhost/=127.0.0.1/" /opt/local/etc/postfix/sql/mysql_sender_login_maps
sed -i "s/=postfix_mysqlhost/=127.0.0.1/" /opt/local/etc/postfix/sql/mysql_virtual_alias_maps
sed -i "s/=postfix_mysqlhost/=127.0.0.1/" /opt/local/etc/postfix/sql/mysql_virtual_mailbox_domains
sed -i "s/=postfix_mysqlhost/=127.0.0.1/" /opt/local/etc/postfix/sql/mysql_virtual_mailbox_maps

if mdata-get postfix_mysqluser 1>/dev/null 2>&1; then
  MYSQLUSER=`mdata-get postfix_mysqluser`
  sed -i "s/=postfix_mysqluser/=${MYSQLUSER}/" /opt/local/etc/postfix/sql/mysql_sender_login_maps
  sed -i "s/=postfix_mysqluser/=${MYSQLUSER}/" /opt/local/etc/postfix/sql/mysql_virtual_alias_maps
  sed -i "s/=postfix_mysqluser/=${MYSQLUSER}/" /opt/local/etc/postfix/sql/mysql_virtual_mailbox_domains
  sed -i "s/=postfix_mysqluser/=${MYSQLUSER}/" /opt/local/etc/postfix/sql/mysql_virtual_mailbox_maps
fi

if mdata-get postfix_mysqlpassword 1>/dev/null 2>&1; then
  MYSQLPWD=`mdata-get postfix_mysqlpassword`
  sed -i "s/=postfix_mysqlpassword/=${MYSQLPWD}/" /opt/local/etc/postfix/sql/mysql_sender_login_maps
  sed -i "s/=postfix_mysqlpassword/=${MYSQLPWD}/" /opt/local/etc/postfix/sql/mysql_virtual_alias_maps
  sed -i "s/=postfix_mysqlpassword/=${MYSQLPWD}/" /opt/local/etc/postfix/sql/mysql_virtual_mailbox_domains
  sed -i "s/=postfix_mysqlpassword/=${MYSQLPWD}/" /opt/local/etc/postfix/sql/mysql_virtual_mailbox_maps
fi

if mdata-get postfix_mysqldbname 1>/dev/null 2>&1; then
  MYSQDB=`mdata-get postfix_mysqldbname`
  sed -i "s/=postfix_mysqldbname/=${MYSQDB}/" /opt/local/etc/postfix/sql/mysql_sender_login_maps
  sed -i "s/=postfix_mysqldbname/=${MYSQDB}/" /opt/local/etc/postfix/sql/mysql_virtual_alias_maps
  sed -i "s/=postfix_mysqldbname/=${MYSQDB}/" /opt/local/etc/postfix/sql/mysql_virtual_mailbox_domains
  sed -i "s/=postfix_mysqldbname/=${MYSQDB}/" /opt/local/etc/postfix/sql/mysql_virtual_mailbox_maps
fi

if mdata-get postfix_mynetworks 1>/dev/null 2>&1; then
  MYNETWORK=`mdata-get postfix_mynetworks`
  sed -i "s/= 127.0.0.1/= ${MYNETWORK}/" /opt/local/etc/postfix/main.cf
fi

if mdata-get postfix_hostname 1>/dev/null 2>&1; then
  MYHOSTNAME=`mdata-get postfix_hostname`
  sed -i "s/= mail.example.com/= ${MYHOSTNAME}/" /opt/local/etc/postfix/main.cf
fi

if mdata-get postfix_hostname 1>/dev/null 2>&1; then
  MYORIGIN=`mdata-get postfix_postmaster | awk -F @ {'print$2'}`
  sed -i "s/= example.com/= ${MYORIGIN}/" /opt/local/etc/postfix/main.cf
fi

if mdata-get masquerade_domains 1>/dev/null 2>&1; then
  MASQUERADE=`mdata-get masquerade_domains`
  sed -i \
      "s/masquerade_domains               = example.com/masquerade_domains               = ${MASQUERADE}/" \
      /opt/local/etc/postfix/main.cf
fi

if mdata-get postfix_tls_only 1>/dev/null 2>&1; then
  if [ "`mdata-get postfix_tls_only`" = "true" ]; then
    gsed -i \
         -e "s/smtpd_tls_security_level         = may/smtpd_tls_security_level         = encrypt/" \
         -e "s/smtpd_tls_ciphers                = high/smtpd_tls_ciphers                = strong/" \
         -e "s/smtpd_tls_protocols              = !SSLv2,!SSLv3/smtpd_tls_protocols              = !SSLv2,!SSLv3,!TLSv1,!TLSv1.1/" \
         -e "s/smtpd_tls_mandatory_protocols    = !SSLv2,!SSLv3/smtpd_tls_mandatory_protocols    = !SSLv2,!SSLv3,!TLSv1,!TLSv1.1/" \
         -e "s/smtp_tls_security_level          = may/smtp_tls_security_level          = encrypt/" \
         -e "s/smtp_tls_protocols               = !SSLv2,!SSLv3/smtp_tls_protocols               = !SSLv2,!SSLv3,!TLSv1,!TLSv1.1/" \
         -e "s/smtp_tls_mandatory_protocols     = !SSLv2,!SSLv3/smtp_tls_mandatory_protocols     = !SSLv2,!SSLv3,!TLSv1,!TLSv1.1/" \
         -e "s/tlsproxy_tls_protocols           = !SSLv2,!SSLv3/tlsproxy_tls_protocols           = !SSLv2,!SSLv3,!TLSv1,!TLSv1.1/" \
         -e "s/tlsproxy_tls_mandatory_protocols = !SSLv2,!SSLv3/tlsproxy_tls_mandatory_protocols = !SSLv2,!SSLv3,!TLSv1,!TLSv1.1/" \
         /opt/local/etc/postfix/main.cf
  fi
fi

svcadm enable svc:/pkgsrc/postfix:default
