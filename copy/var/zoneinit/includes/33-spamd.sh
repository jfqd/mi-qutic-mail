# initialize spammassasin
sudo -u spamd /opt/local/bin/sa-update

# create cronjob for sa-update
CRON='35 4 * * * sudo -u spamd /opt/local/bin/sa-update --nogpg --channel spamassassin.heinlein-support.de
42 4 * * * sudo -u spamd /opt/local/bin/sa-update ; /usr/sbin/svcadm restart svc:/pkgsrc/amavisd:default'
(crontab -l 2>/dev/null || true; echo "$CRON" ) | sort | uniq | crontab

# Run pyzor discover
sudo -u spamd /opt/local/bin/pyzor --homedir /opt/local/etc/spamassassin ping || \
	sudo -u spamd /opt/local/bin/pyzor --homedir /opt/local/etc/spamassassin discover

# remove spamassassin service
svccfg delete svc:/pkgsrc/spamassassin:default

# enable spamassassin service
svcadm enable svc:/pkgsrc/amavisd:default
