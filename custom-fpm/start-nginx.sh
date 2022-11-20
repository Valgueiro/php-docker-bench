#!/usr/bin/with-contenv sh
set -e;

/tmp/wait-for-it.sh -t 120 127.0.0.1:9000

/usr/sbin/nginx
