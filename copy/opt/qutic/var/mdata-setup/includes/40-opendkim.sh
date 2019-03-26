if mdata-get postfix_hostname 1>/dev/null 2>&1; then
  MYHOSTNAME=`mdata-get postfix_hostname`
  sed -i "s/# AuthservID\t\texample.com/AuthservID\t\t${MYHOSTNAME}/" /opt/local/etc/opendkim.conf
  /usr/sbin/svcadm enable -r svc:/pkgsrc/opendkim:default
fi
