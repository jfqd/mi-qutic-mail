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

/usr/sbin/svcadm enable -r svc:/pkgsrc/opendmarc:default