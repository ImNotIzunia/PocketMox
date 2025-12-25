# Security Changelog – PocketMox

This document tracks security-related changes, mitigations, and decisions.

---

## [2025-12-25]

### Added
- VEX documentation for **CVE-2023-39810 (BusyBox cpio)**
- Security documentation folder (`security/`)
- SECURITY.md explaining vulnerability handling and reporting

### Analysis
- BusyBox v1.37.0-6+b3 present as system dependency
- Vulnerable applet (`cpio`) confirmed not used
- GNU cpio (`/usr/bin/cpio`) used instead
- No systemd units or scripts invoking `busybox cpio`
- Exploitation requires privileged shell access, no impact

### Decision
- Vulnerability marked **not_affected** via VEX
- BusyBox not removed to avoid breaking system dependencies
- No custom BusyBox build introduced to keep maintenance low