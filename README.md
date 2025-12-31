# PocketMox

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Latest Release](https://img.shields.io/github/v/release/ImNotIzunia/PocketMox)](https://github.com/ImNotIzunia/PocketMox/releases)
[![Docker Hub](https://img.shields.io/docker/pulls/izunia/pocketmox)](https://hub.docker.com/r/izunia/pocketmox)


PocketMox is a **Docker Version** of **Proxmox Datacenter Manager**, designed to be easy to deploy while keeping a strong focus on reliability and security.

> /!\ PocketMox runs systemd inside a **privileged container**. This is **intentional** and **required** for Proxmox components.

## Installation

The container requires :
- privileged mode
- tmpfs mounts (`/run`, `/run/lock`)
- `cgroup` access
- environment configuration via `.env`

For this reason, Pocketmox must be started using **Docker Compose**.

### Docker Compose 

```yml
version: "3.9"

services:
    pocketmox: izunia/pocketmox:latest # Or a defined version
    container_image: pocketmox
    hostname: pocketmox

    restart: unless-stopped
    privileged: true

    environment:
      ROOT_PASSWORD: ${ROOT_PASSWORD} # Defined in the env file
    
    security_opt:
      - seccomp:unconfined

    volumes:
      - /sys/fs/cgroup:/sys/fs/cgroup:rw
      - /tmp:/tmp

    tmpfs:
      - /run
      - /run/lock

    ports:
      - "${PDM_PORT:-8443}:8443" # The port can be changed with the env file

```

### Env File 

```.env
PDM_PORT=8443
ROOT_PASSWORD=changeme
```

## Authentication

### Root Password

- If the `ROOT_PASSWORD` is not provided, PocketMox generates a random password at startup.

- The generated password is displayed once in container logs.

## Web Interface

- `URL` : `http://<HOST>:8443`
- `User` : root
- `Password` : generated or provided

## Security Notes

PocketMox is designed to be explicit and observable, not magically hardened.
- No implicit privilege escalation
- Security hardening is progressive and documented
- Users are responsible for reviewing configuration before production use
- The VEX Documentation is kept up to date with the release of new versions

Do not expose this service directly to the Internet without additional safeguards.

## CI And Quality

PocketMox CI includes :
- ShellCheck (Bash linting)
- Docker build validation
- Runtime systemd tests
- Trivy security scanning
- Multi-registry image publishing

## Versioning

PocketMox follows semantic versioning :
- `latest` : reflects the current `main` branch
- `vX.Y.Z` : immutable tagged release

The versions are defined as follow :
- `MAJOR` : breaking changes
- `MINOR` : backward-compatible enhancements
- `PATCH` : bug and security fixes

## Contributing

This is a personal project maintained by a single contributor.

All issues and pull requests are welcome. 
Please keep security and stability in mind when contributing.

## License

MIT License
