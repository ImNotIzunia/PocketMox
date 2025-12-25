# Security Policy - PocketMox

PocketMox is a containerized version of Proxmox Datacenter Manager (PDM).

This document explains how security vulnerabilities are handled, documented and communicated.

---

## Vulnerability Scanning

PocketMox is regularly scanned using :
- Trivy (container and OS package scanning)

Scan results may include vulnerabilities that are **present but not exploitable** in the context of PocketMox. These cases are documented using VEX.

---

## Known Vulnerabilities and VEX

Some vulnerabilities detected by automated scanners are not exploitable due to the architecture or runtime behavior of PocketMox.

These cases are documented in :
- `security/vex.yml`

Example:
- **CVE-2023-39810 (BusyBox – cpio applet)**
  - BusyBox is present as a system dependency.
  - The vulnerable applet is not used by PocketMox or Proxmox Datacenter Manager.
  - GNU cpio is used instead.
  - No service or script invokes `busybox cpio`.
  - Exploitation would require prior privileged shell access.

See `security/vex.yaml` for full technical justification and evidence.

---

## Reporting a Vulnerability

If you discover a security issue:
- Please open a private issue or contact the maintainer directly.
- Include as much technical detail as possible (logs, reproduction steps).

Responsible disclosure is appreciated.