#!/bin/bash

echo "proxy_username:$PASSWORD" | chpasswd
/etc/init.d/stunnel4 start
/usr/sbin/danted