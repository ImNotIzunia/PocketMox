FROM debian:trixie

ENV container=docker
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y systemd systemd-sysv dbus dbus-user-session \
                       wget ca-certificates gnupg && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/share/keyrings && \
    wget https://enterprise.proxmox.com/debian/proxmox-archive-keyring-trixie.gpg \
        -O /usr/share/keyrings/proxmox-archive-keyring.gpg

RUN printf "Types: deb\nURIs: http://download.proxmox.com/debian/pdm/\nSuites: trixie\nComponents: pdm-test\nSigned-By: /usr/share/keyrings/proxmox-archive-keyring.gpg\n" \
    > /etc/apt/sources.list.d/pdm-test.sources

RUN apt-get update && \
    apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
        proxmox-datacenter-manager proxmox-datacenter-manager-ui && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN echo "root:admin" | chpasswd

VOLUME [ "/sys/fs/cgroup" ]
CMD ["/sbin/init"]
