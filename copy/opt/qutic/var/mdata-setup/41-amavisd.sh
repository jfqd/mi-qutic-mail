if mdata-get postfix_postmaster 1>/dev/null 2>&1; then
  POSTMASTER=`mdata-get postfix_postmaster | awk -F @ {'print$2'}`
  sed -i "s/$mydomain = 'example.com'/$mydomain = '${POSTMASTER}'/" /opt/local/etc/amavisd.conf
fi
