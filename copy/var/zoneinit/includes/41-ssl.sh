# This script will try to manage the ssl certificates for us.

# Default
SSL_HOME='/opt/local/etc/ssl'
SSL_PRIVATE='/opt/local/etc/ssl/private'

# Use user certificate if provided
if mdata-get mail_ssl 1>/dev/null 2>&1; then
  (
  umask 0077
  mdata-get mail_ssl > "${SSL_PRIVATE}"/cert.pem
  # Split file for dovecot and postfix usage
  openssl pkey -in "${SSL_PRIVATE}/cert.pem" -out "${SSL_PRIVATE}/cert.key"
  openssl crl2pkcs7 -nocrl -certfile "${SSL_PRIVATE}/cert.pem" | \
    openssl pkcs7 -print_certs -out "${SSL_HOME}/cert.crt"
  )
else
  /opt/qutic/bin/ssl-selfsigned.sh -d "${SSL_HOME}" -f cert
  mv "${SSL_HOME}"/cert.{key,pem} "${SSL_PRIVATE}"
  rm "${SSL_HOME}"/cert.csr
fi
mv "${SSL_HOME}"/cert.crt "${SSL_HOME}"/cert.pem
chmod 0644 "${SSL_HOME}"/cert.*
chmod 0440 "${SSL_PRIVATE}"/cert.*
