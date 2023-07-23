#!/bin/sh
set -e

# Apache gets grumpy about PID files pre-existing
rm -f /var/run/httpd/httpd.pid

. /etc/apache2/envvars
exec /usr/sbin/apache2 -DFOREGROUND "$@"