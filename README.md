# Server Infrastructure & Hardening Local Lab

A hands-on infrastructure provisioning and web server hardening project. This repository documents the setup, configuration, and validation of a multi-service Linux environment covering system administration, reverse proxying, load balancing, PKI, and security auditing.

## Overview

This project simulates a production-like server environment where multiple web services are provisioned, isolated by port, secured with SSH key authentication, fronted by a load balancer, and monitored through system auditing tools. It demonstrates core operational security (OpSec) practices applied to a real Linux server stack.

## Environment

| Component | Details |
|---|---|
| OS | Ubuntu Server 26.04 |
| Web Servers | Apache2, Nginx |
| Load Balancer | HAProxy |
| Remote Access | OpenSSH |
| PKI / TLS | OpenSSL |

## Architecture & Services

| Service | Port | Description |
|---|---|---|
| SSH | 2025 | Remote administration, public key authentication only |
| Apache | 8028 | Virtual host serving primary content |
| Nginx | 8128 | Virtual host serving secondary content |
| HTTPS | 8428 | TLS-terminated endpoint secured with a self-signed Root CA |
| HAProxy | 80 | Load balancer distributing traffic across backend services |

## Features

- **User Management** = 1,300 provisioned Linux user accounts
- **SSH Hardening** = Public key authentication enforced, password login disabled
- **PKI Infrastructure** = Custom Root CA for issuing and validating internal TLS certificates
- **Apache Virtual Host** = Isolated site configuration on a dedicated port
- **Nginx Virtual Host** = Isolated site configuration on a dedicated port
- **HTTPS Enforcement** = TLS-secured endpoint backed by the internal Root CA
- **Load Balancing** = HAProxy distributing requests across Apache and Nginx backends
- **Auditing** = `auditd` rules for tracking security-relevant system events
- **Centralized Logging** = `rsyslog` configuration for log aggregation
- **Resource Limits** = `ulimit` tuning to prevent resource exhaustion

## Validation

Each service was tested and verified using the following tools:

| Tool | Purpose |
|---|---|
| `curl` | Verifying HTTP/HTTPS endpoint responses |
| `systemctl` | Confirming service status and enablement |
| `openssl` | Validating certificates and TLS handshakes |
| `ssh` | Confirming key-based authentication and connectivity |
| `auditctl` | Verifying active audit rules |

## Getting Started

> Add setup/installation instructions here (e.g. provisioning scripts, configuration file locations, and steps to reproduce the environment).

```bash
# Example: check service status
systemctl status apache2 nginx haproxy ssh

# Example: verify HTTPS endpoint
curl -vk https://localhost:8428

# Example: verify SSH key auth
ssh -p 2025 user@host

# Example: check active audit rules
sudo auditctl -l
```

## Repository Structure

> Add a brief description of key folders/files (e.g. configs for Apache, Nginx, HAProxy, audit rules, provisioning scripts).

```
.
├── apache/
├── nginx/
├── haproxy/
├── ssl/
├── audit/
└── README.md
```
