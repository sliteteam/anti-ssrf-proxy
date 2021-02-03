#!/bin/bash

echo "proxy_username:$PASSWORD" | chpasswd
if [ "$TLS" = "true" ]
then
  /etc/init.d/stunnel4 start
  sed -i 's/# TLS //g' /etc/danted.conf
else
  sed -i 's/# NOTLS //g' /etc/danted.conf
fi
/usr/sbin/danted