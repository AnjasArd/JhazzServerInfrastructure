#!/bin/bash

LOG=logs/validation.log

mkdir -p logs

exec > >(tee "$LOG") 2>&1

echo "======================================="
echo "CEK VALIDASI KONFIGURASI TASKOPSEC 2025 "
echo "======================================="

echo
echo "Hostname"
hostnamectl

echo
echo "Apache"
systemctl status apache2 --no-pager

echo
echo "Nginx"
systemctl status nginx --no-pager

echo
echo "HAProxy"
systemctl status haproxy --no-pager

echo
echo "SSH"
systemctl status ssh --no-pager

echo
echo "Audit"
systemctl status auditd --no-pager

echo
echo "Rsyslog"
systemctl status rsyslog --no-pager

echo
echo "Ports"
ss -tlnp

echo
echo "Apache Test"
curl http://localhost:8028

echo
echo "Nginx Test"
curl http://localhost:8128

echo
echo "HTTPS Test"
curl -k https://localhost:8428

echo
echo "HAProxy Validation"
haproxy -c -f /etc/haproxy/haproxy.cfg

echo
echo "Certificate"
sudo openssl verify \
-CAfile /root/ca/cacert.pem \
/root/ca/certs/barat.sevima.site.crt


