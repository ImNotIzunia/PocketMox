FROM debian:trixie

LABEL org.opencontainers.image.title="PocketMox"
LABEL org.opencontainers.image.description="Proxmox Datacenter Manager (PDM) Docker Container"
LABEL org.opencontainers.image.authors="Charles Berthet"


ENV container=docker
ENV DEBIAN_FRONTEND=noninteractive


RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
        systemd systemd-sysv \
        dbus dbus-user-session \
        wget ca-certificates gnupg && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/share/keyrings && \
    wget https://enterprise.proxmox.com/debian/proxmox-archive-keyring-trixie.gpg \
        -O /usr/share/keyrings/proxmox-archive-keyring.gpg

RUN printf "Types: deb\nURIs: http://download.proxmox.com/debian/pdm/\nSuites: trixie\nComponents: pdm-test\nSigned-By: /usr/share/keyrings/proxmox-archive-keyring.gpg\n" \
    > /etc/apt/sources.list.d/pdm.sources

RUN apt-get update && \
    apt-get install -y \
        proxmox-datacenter-manager \
        proxmox-datacenter-manager-ui && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

    
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh


VOLUME [ "/sys/fs/cgroup" ]


HEALTHCHECK --interval=30s --timeout=5s --start-period=60s \
    CMD systemctl is-active proxmox-datacenter-manager || exit 1


CMD ["/entrypoint.sh"]