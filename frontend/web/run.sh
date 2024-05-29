#!/bin/bash

[ ! -d '/tmp/cache' ] && mkdir -p /tmp/cache

HOSTNAME=0.0.0.0 PORT=8080 exec node server.js
