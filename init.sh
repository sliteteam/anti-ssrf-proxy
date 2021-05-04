#!/bin/bash

if [ "$TLS" = "true" ]
then
  /etc/init.d/stunnel4 start
  sed -i 's/# TLS //g' /etc/danted.conf
else
  sed -i 's/# NOTLS //g' /etc/danted.conf
fi

if [ "$AUTH" = "false" ]
then
  sed -i 's/username/none/g' /etc/danted.conf
else
  if [ -z "$PASSWORD" ];
  then
    echo PASSWORD not specified
    exit
  else
    echo "proxy_username:$PASSWORD" | chpasswd
  fi
fi

/usr/sbin/danted