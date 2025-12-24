#!/bin/bash

set -e


echo "=================================================="
echo " PocketMox - Proxmox Datacenter Manager in Docker "
echo "=================================================="


if [ -n "$ROOT_PASSWORD" ]; then
    echo "[INFO] Setting root password"
    echo "root:${ROOT_PASSWORD}" | chpasswd
else
    echo "[WARNING] ROOT_PASSWORD is not set"
    echo "[WARNING] Root login may be disabled or inaccessible"
fi


echo "--------------------------------------------------"
echo "[READY] Proxmox Datacenter Manager is running"
echo "[INFO] Web UI available on :"
echo "       https://<HOST>:8443"
echo "--------------------------------------------------"

echo "[SECURITY]"
echo "- This container runs in privileged mode"
echo "- Ensure you have set a strong ROOT_PASSWORD environment variable"
echo "--------------------------------------------------"

exec /sbin/init