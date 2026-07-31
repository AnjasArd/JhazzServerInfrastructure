# TASKOPSEC 2025

## Environment

- Ubuntu Server 26.04
- Apache2
- Nginx
- HAProxy
- OpenSSH
- OpenSSL

---

## Services

| Service | Port |
|---------|------|
| SSH | 2025 |
| Apache | 8028 |
| Nginx | 8128 |
| HTTPS | 8428 |
| HAProxy | 80 |

---

## Features

- 1300 Linux User
- SSH Public Key Authentication
- Root CA
- Apache Virtual Host
- Nginx Virtual Host
- HTTPS
- HAProxy Load Balancing
- Auditd
- Rsyslog
- Ulimit Configuration

---

## Validation

Semua layanan berhasil divalidasi menggunakan:

- curl
- systemctl
- openssl
- ssh
- auditctl
