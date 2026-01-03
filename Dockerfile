FROM debian:trixie-slim AS base

ENV container=docker
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
        systemd systemd-sysv \
        dbus dbus-user-session \
        wget ca-certificates gnupg && \
    apt-get clean && rm -rf /var/lib/apt/lists/*



FROM base AS pdm

RUN mkdir -p /usr/share/keyrings && \
    wget https://enterprise.proxmox.com/debian/proxmox-archive-keyring-trixie.gpg \
        -O /usr/share/keyrings/proxmox-archive-keyring.gpg

RUN printf "Types: deb\n\
URIs: http://download.proxmox.com/debian/pdm/\n\
Suites: trixie\n\
Components: pdm-test\n\
Signed-By: /usr/share/keyrings/proxmox-archive-keyring.gpg\n" \
    > /etc/apt/sources.list.d/pdm.sources

RUN apt-get update && \
    apt-get install -y \
        proxmox-datacenter-manager \
        proxmox-datacenter-manager-ui && \
    apt-get clean && rm -rf /var/lib/apt/lists/*


FROM pdm AS runtime

LABEL org.opencontainers.image.title="PocketMox"
LABEL org.opencontainers.image.description="Proxmox Datacenter Manager (PDM) Docker Container"
LABEL org.opencontainers.image.authors="Izunia"

COPY entrypoint.sh /entrypoint.sh
COPY healthcheck.sh /healthcheck.sh

RUN chmod +x /entrypoint.sh && \
    chmod +x /healthcheck.sh


VOLUME [ "/sys/fs/cgroup" ]

HEALTHCHECK --interval=30s --timeout=5s --start-period=90s \
  CMD /healthcheck.sh >/dev/null 2>&1 || exit 1

CMD ["/entrypoint.sh"]
