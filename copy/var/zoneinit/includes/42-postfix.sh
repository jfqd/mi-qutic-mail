# change dh-files on every provisioning
# openssl dhparam -out /opt/local/etc/postfix/dh4096.pem 4096
openssl dhparam -out /opt/local/etc/postfix/dh2048.pem 2048
openssl dhparam -out /opt/local/etc/postfix/dh1024.pem 1024
openssl dhparam -out /opt/local/etc/postfix/dh512.pem 512
chmod 0400 /opt/local/etc/postfix/dh*.pem

# add stub for postfix
touch /opt/local/etc/postfix/client_checks
touch /opt/local/etc/postfix/sender_checks
/opt/local/sbin/postmap hash:/opt/local/etc/postfix/client_checks
/opt/local/sbin/postmap hash:/opt/local/etc/postfix/sender_checks
