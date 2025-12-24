#!/bin/bash

set -e


echo "=================================================="
echo " PocketMox - Proxmox Datacenter Manager in Docker "
echo "=================================================="


if [ -z "$ROOT_PASSWORD" ]; then
    echo "[INFO] No ROOT_PASSWORD provided"
    echo "[INFO] Generating a random password"
    ROOT_PASSWORD=$(openssl rand -base64 20)
    PASSWORD_GENERATED=true
else
    echo "[INFO] Using provided ROOT_PASSWORD"
    PASSWORD_GENERATED=false
fi

echo "root:${ROOT_PASSWORD}" | chpasswd

echo "--------------------------------------------------"
echo "[READY] Proxmox Datacenter Manager is running"
echo "[INFO] Web UI available on :"
echo "URL:      https://<HOST>:8443"
echo " "

echo "[INFO] Login Credentials :"
echo "User:     root"

if [ "$PASSWORD_GENERATED" = true ]; then
    echo "Password: ${ROOT_PASSWORD}"
    echo "[INFO] Generated Password - Please store it"
else 
    echo "Password: ${ROOT_PASSWORD}"
fi

echo "--------------------------------------------------"

echo "[SECURITY]"
echo "- This container runs in privileged mode"
echo "- Ensure you have set a strong ROOT_PASSWORD environment variable"
echo "--------------------------------------------------"

exec /sbin/init