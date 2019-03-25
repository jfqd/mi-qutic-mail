if mdata-get postfix_hostname 1>/dev/null 2>&1; then
  MYHOSTNAME=`mdata-get postfix_hostname`
  sed -i "s/Authserv_Id = HEADER/Authserv_Id = ${MYHOSTNAME}/" /opt/local/etc/python-policyd-spf/policyd-spf.conf
fi
