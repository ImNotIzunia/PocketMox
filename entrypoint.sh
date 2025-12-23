#!/bin/bash

set -e

if [ -n "$ROOT_PASSWORD" ]; then
    echo "root:${ROOT_PASSWORD}" | chpasswd
fi

exec /sbin/init