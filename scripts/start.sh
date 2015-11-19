#!/bin/bash

chmod 600 /etc/aws
mkdir -p /mnt/live/multi
chown nobody /mnt/live/multi
chmod 700 /mnt/live/multi
/usr/local/nginx/sbin/nginx -c /etc/conf/nginx.conf
