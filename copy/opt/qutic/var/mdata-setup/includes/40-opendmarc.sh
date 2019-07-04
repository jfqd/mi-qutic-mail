if mdata-get postfix_hostname 1>/dev/null 2>&1; then
  MYHOSTNAME=`mdata-get postfix_hostname`
  sed -i \
      "s/# AuthservID name/# AuthservID ${MYHOSTNAME}/" \
      /opt/local/etc/opendmarc/opendmarc.conf
fi

if mdata-get trusted_servers 1>/dev/null 2>&1; then
  TRUSTED_SERVERS=`mdata-get trusted_servers`
  sed -i \
      "s/# TrustedAuthservIDs HOSTNAME/TrustedAuthservIDs ${TRUSTED_SERVERS}/" \
      /opt/local/etc/opendmarc/opendmarc.conf
fi

if mdata-get postfix_mynetworks 1>/dev/null 2>&1; then
  for host in `mdata-get postfix_mynetworks | sed  's/,/ /g'` ; do
    echo $host >> /opt/local/etc/opendmarc/ignore.hosts
  done
fi

if mdata-get opendmarc_mysqlpassword 1>/dev/null 2>&1; then
  OPENDMARC_DB_PWD=`mdata-get opendmarc_mysqlpassword`
  sed -i "s#opendmarc-password#${OPENDMARC_DB_PWD}#g" /opt/qutic/bin/opendmarc-reporter
fi

if mdata-get postfix_postmaster 1>/dev/null 2>&1; then
  REPORT_EMAIL=`mdata-get postfix_postmaster`
  sed -i "s#report@example.com#${REPORT_EMAIL}#g" /opt/qutic/bin/opendmarc-reporter
fi

/usr/sbin/svcadm enable -r svc:/pkgsrc/opendmarc:default

CRON='0 3 * * * sudo -u opendmarc /opt/qutic/bin/opendmarc-reporter 2>/dev/null'
(crontab -l 2>/dev/null || true; echo "$CRON" ) | sort | uniq | crontab
