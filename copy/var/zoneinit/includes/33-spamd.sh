# initialize spammassasin
sudo -u spamd /opt/local/bin/sa-update

# create cronjob for sa-update
CRON='42 7 * * * sudo -u spamd /opt/local/bin/sa-update && kill -SIGHUP $(cat /var/spamassassin/spamd.pid)'
(crontab -l 2>/dev/null || true; echo "$CRON" ) | sort | uniq | crontab

# Run pyzor discover
sudo -u spamd /opt/local/bin/pyzor --homedir /opt/local/etc/spamassassin ping || \
	sudo -u spamd /opt/local/bin/pyzor --homedir /opt/local/etc/spamassassin discover

# remove spamassassin service
svccfg delete svc:/pkgsrc/spamassassin:default

# enable spamassassin service
svcadm enable svc:/pkgsrc/amavisd:default
