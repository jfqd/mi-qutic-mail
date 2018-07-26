logadm -w '/var/log/spamd/spamd.log'  -A 7d -p 1d -c -N -o spamd -g spamd -m 640
logadm -w '/var/log/clamav/clamd.log' -A 7d -p 1d -c -N -o clamav -g clamav -m 640
logadm -w maillog    -C 53 -o root -g sys  -m 0644 -a '/usr/sbin/svcadm refresh system-log' -p 7d -s 4m /var/log/mail.log
logadm -w dovecotlog -C 53 -o root -g root -m 0644 -a '/opt/local/bin/doveadm log reopen'   -p 7d -s 4m /var/log/dovecot.log
logadm -w ipflog     -C 30 -o root -g sys  -m 0640 -a '/usr/sbin/svcadm refresh system-log' -p 7d -s 5m /var/log/ipf.log
