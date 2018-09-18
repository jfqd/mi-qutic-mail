if mdata-get spiped_key 1>/dev/null 2>&1; then
  SPIPED_KEY=`mdata-get spiped_key`
  echo "$SPIPED_KEY" | tr -d '\n' > /etc/ssh/spiped.key
fi

if mdata-get spiped_redis_host 1>/dev/null 2>&1; then
  SPIPED_REDIS_HOST=`mdata-get spiped_redis_host`
  sed -i "s/-t 127.0.0.1:26379/-t $SPIPED_REDIS_HOST:26379/g" /opt/local/lib/svc/manifest/spiped-redis.xml
  svccfg import /opt/local/lib/svc/manifest/spiped-redis.xml
fi

if mdata-get spiped_percona_host 1>/dev/null 2>&1; then
  SPIPED_PERCONA_HOST=`mdata-get spiped_percona_host`
  sed -i "s/-t 127.0.0.1:23306/-t $SPIPED_PERCONA_HOST:23306/g" /opt/local/lib/svc/manifest/spiped-percona.xml
  svccfg import /opt/local/lib/svc/manifest/spiped-percona.xml
fi

if mdata-get postfix_mysqluser 1>/dev/null 2>&1; then
  MYSQLUSER=`mdata-get postfix_mysqluser`
  sed -i "s/user = postfix_mysqluser/user = $MYSQLUSER/" /root/.my.cnf
fi

if mdata-get postfix_mysqlpassword 1>/dev/null 2>&1; then
  MYSQLPWD=`mdata-get postfix_mysqlpassword`
  sed -i "s/password = postfix_mysqlpassword/password = $MYSQLPWD/" /root/.my.cnf
fi
