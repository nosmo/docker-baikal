#!/bin/bash
source /etc/apache2/envvars

mkdir -p "$APACHE_LOCK_DIR" "$APACHE_RUN_DIR"

/usr/sbin/apache2 -DFOREGROUND
