if mdata-get vmail_cleanup 1>/dev/null 2>&1; then
  if [ "`mdata-get vmail_cleanup`" = "true" ]; then
    CRON='45 2 * * * sudo -u vmail /opt/qutic/bin/vmail-cleanup'
    (crontab -l 2>/dev/null || true; echo "$CRON" ) | sort | uniq | crontab
  fi
fi
