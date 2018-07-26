if mdata-get spiped_key 1>/dev/null 2>&1; then
  SPIPED_KEY=`mdata-get spiped_key`
  echo "$SPIPED_KEY" | tr -d '\n' > /etc/ssh/spiped.key
fi

if mdata-get spiped_redis_host 1>/dev/null 2>&1; then
  SPIPED_REDIS_HOST=`mdata-get spiped_redis_host`
  sed -i "s/-t 127.0.0.1:26379/-t $SPIPED_REDIS_HOST:26379/g" /opt/local/lib/svc/spiped-redis.xml
  svccfg import /opt/local/lib/svc/spiped-redis.xml
fi

if mdata-get spiped_percona_host 1>/dev/null 2>&1; then
  SPIPED_PERCONA_HOST=`mdata-get spiped_percona_host`
  sed -i "s/-t 127.0.0.1:23306/-t $SPIPED_PERCONA_HOST:23306/g" /opt/local/lib/svc/spiped-percona.xml
  svccfg import /opt/local/lib/svc/spiped-percona.xml
fi
