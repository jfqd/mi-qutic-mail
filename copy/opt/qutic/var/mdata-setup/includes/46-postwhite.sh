CRON='10 1 * * 6 sudo -u postfix /opt/local/bin/scrape_yahoo'
(crontab -l 2>/dev/null || true; echo "$CRON" ) | sort | uniq | crontab
CRON='20 1 * * * sudo -u postfix /opt/local/bin/postwhite-wrapper'
(crontab -l 2>/dev/null || true; echo "$CRON" ) | sort | uniq | crontab
