if mdata-get vmail_cleanup 1>/dev/null 2>&1; then
  if [ "`mdata-get vmail_cleanup`" = "true" ]; then
    CRON='45 2 * * * sudo -u vmail /opt/qutic/bin/vmail-cleanup'
    (crontab -l 2>/dev/null || true; echo "$CRON" ) | sort | uniq | crontab
  fi
fi

# prevent logadm from going wild
CRON='5 * * * * [[ `/usr/bin/ps auxwww | /usr/bin/grep logadm | /usr/bin/wc -l` -gt 5 ]] && /usr/bin/pkill logadm'
(crontab -l 2>/dev/null || true; echo "$CRON" ) | sort | uniq | crontab

# send stats to zabbix
CRON="0,5,10,15,20,25,30,35,40,45,50,55 * * * * sudo -u zabbix /opt/local/bin/zabbix_postfix 1>/dev/null 2>/dev/null"
(crontab -l 2>/dev/null || true; echo "$CRON" ) | sort | uniq | crontab