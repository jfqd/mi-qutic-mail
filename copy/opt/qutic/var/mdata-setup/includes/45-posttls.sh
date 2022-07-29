# setup cron for posttls
CRON='0,2,4,6,8,10,12,14,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58 * * * * sudo -u vmail /opt/local/var/vmail/posttls'
(crontab -l 2>/dev/null || true; echo "$CRON" ) | sort | uniq | crontab

# TODO: setup vars in .env file