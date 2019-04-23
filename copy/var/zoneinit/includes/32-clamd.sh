# CRON='15 * * * * sudo -u clamav /opt/local/bin/clamav-unofficial-sigs > /dev/null'
# (crontab -l 2>/dev/null || true; echo "$CRON" ) | sort | uniq | crontab

# run freshclamd once on provisioning
/opt/local/bin/freshclam

# enable clamav services
/usr/sbin/svcadm enable svc:/pkgsrc/clamav:clamd
/usr/sbin/svcadm enable svc:/pkgsrc/clamav:freshclamd
