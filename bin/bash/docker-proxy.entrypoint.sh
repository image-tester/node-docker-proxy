#!/bin/bash
############################################################
##
## Allows for follow-through of commands.
## sh entrypoint.sh pwd
## will run the entrypoint scripts and then execute "pwd"
##
## supervisord -c /etc/supervisor/supervisord.conf -u root -n
##
############################################################

## Run SupervisorD
if [ -f "/etc/supervisor/supervisord.conf" ]; then
  mkdir -p /var/log/supervisor 2>/dev/null;
  mkdir -p /var/run/supervisor 2>/dev/null;
  supervisord -c /etc/supervisor/supervisord.conf -u root
  echo "Docker Proxy: Started supervisor."
else
  echo "Docker Proxy: Missing Supervisor configuration file."
fi

# docker-proxy start

## Pipe/Follow-through other commands.
exec "$@"

