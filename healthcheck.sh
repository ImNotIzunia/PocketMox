#!/bin/sh

set -e


systemctl systemctl is-active proxmox-datacenter-api.service || {
  echo "PDM systemd service is not active"
  exit 1
}

systemctl is-active proxmox-datacenter-privileged-api.service || {
  echo "PDM systemd service is not active"
  exit 1
}


curl -k -fs https://localhost:8443/ || {
  echo "PDM systemd service is not active"
  exit 1
}
