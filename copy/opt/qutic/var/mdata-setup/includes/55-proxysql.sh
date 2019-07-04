#!/bin/bash

if mdata-get proxysql_monitor_pwd 1>/dev/null 2>&1; then
  MONITOR_PWD=`mdata-get proxysql_monitor_pwd`
  sed -i "s#monitor_password=\"monitor\"#monitor_password=\"${MONITOR_PWD}\"#" /opt/local/etc/proxysql.cnf
fi

if mdata-get proxysql_admin_pwd 1>/dev/null 2>&1; then
  PROXY_ADMIN_PWD=`mdata-get proxysql_admin_pwd`
  sed -i "s#admin_credentials=\"admin:admin\"#admin_credentials=\"admin:${PROXY_ADMIN_PWD}\"#" /opt/local/etc/proxysql.cnf
  cat >> /root/.my.cnf << EOF
[client]
host = localhost
port = 3307
user = admin
password = ${PROXY_ADMIN_PWD}
prompt = 'Admin> '
EOF
chmod 0400 /root/.my.cnf
fi

if mdata-get percona_host 1>/dev/null 2>&1; then
  PERCONA_HOST=`mdata-get percona_host`
  sed -i "s/main.example.com/${PERCONA_HOST}/g" /opt/local/etc/proxysql.cnf
fi

if mdata-get percona_fallback 1>/dev/null 2>&1; then
  PERCONA_FALLBACK=`mdata-get percona_fallback`
  sed -i "s/backup.example.com/${PERCONA_FALLBACK}/g" /opt/local/etc/proxysql.cnf
fi

if mdata-get postfix_mysqluser 1>/dev/null 2>&1; then
  PROXY_DB_USER=`mdata-get postfix_mysqluser`
  sed -i "s#db-username#${PROXY_DB_USER}#" /opt/local/etc/proxysql.cnf
fi

if mdata-get postfix_mysqlpassword 1>/dev/null 2>&1; then
  PROXY_DB_PWD=`mdata-get postfix_mysqlpassword`
  sed -i "s#db-password#${PROXY_DB_PWD}#g" /opt/local/etc/proxysql.cnf
fi

if mdata-get amavisd_mysqluser 1>/dev/null 2>&1; then
  AMAVISD_DB_USER=`mdata-get amavisd_mysqluser`
  sed -i "s#amavisd-user#${AMAVISD_DB_USER}#" /opt/local/etc/proxysql.cnf
fi

if mdata-get amavisd_mysqlpassword 1>/dev/null 2>&1; then
  AMAVISD_DB_PWD=`mdata-get amavisd_mysqlpassword`
  sed -i "s#amavisd-password#${AMAVISD_DB_PWD}#g" /opt/local/etc/proxysql.cnf
fi

if mdata-get opendmarc_mysqlpassword 1>/dev/null 2>&1; then
  OPENDMARC_DB_PWD=`mdata-get opendmarc_mysqlpassword`
  sed -i "s#opendmarc-password#${OPENDMARC_DB_PWD}#g" /opt/local/etc/proxysql.cnf
fi

if mdata-get autoresponder_mysqluser 1>/dev/null 2>&1; then
  AUTO_USER=`mdata-get autoresponder_mysqluser`
  sed -i "s#autoresponder-username#${AUTO_USER}#" /opt/local/etc/proxysql.cnf
fi

svcadm enable svc:/pkgsrc/proxysql:default

cat >> /root/.mysql_history << EOF
_HiStOrY_V2_
LOAD\040MYSQL\040SERVERS\040TO\040RUNTIME;
SAVE\040MYSQL\040SERVERS\040TO\040DISK;
SELECT\040*\040FROM\040mysql_servers;
SELECT\040*\040FROM\040stats.stats_mysql_connection_pool;
EOF
chmod 0600 /root/.mysql_history