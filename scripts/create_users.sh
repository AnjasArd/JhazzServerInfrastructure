#!/bin/bash
#
# create_users.sh

set -euo pipefail

TOTAL_USER=1300
PUBKEY="/root/template_authorized_keys"
LOGFILE="/var/log/create_users.log"

# Harus dijalankan sebagai root
if [ "$(id -u)" -ne 0 ]; then
    echo "ERROR: Jalankan script sebagai root."
    exit 1
fi

# Pastikan file public key tersedia
if [ ! -f "$PUBKEY" ]; then
    echo "ERROR: File $PUBKEY tidak ditemukan."
    exit 1
fi

echo "========== $(date) ==========" >> "$LOGFILE"

for i in $(seq 1 $TOTAL_USER)
do
    USERNAME="sevima-adm$i"
    PASSWORD="w3bsite#$i"

    # Skip jika user sudah ada
    if id "$USERNAME" >/dev/null 2>&1; then
        echo "$USERNAME sudah ada. Skip." | tee -a "$LOGFILE"
        continue
    fi

    echo "Membuat user $USERNAME ..." | tee -a "$LOGFILE"

    # Membuat user
    useradd \
        --create-home \
        --shell /bin/bash \
        "$USERNAME"

    # Set password
    echo "${USERNAME}:${PASSWORD}" | chpasswd

    # Tambahkan ke grup sudo
    usermod -aG sudo "$USERNAME"

    # Membuat direktori SSH
    install \
        -d \
        -m 700 \
        -o "$USERNAME" \
        -g "$USERNAME" \
        "/home/$USERNAME/.ssh"

    # Salin authorized_keys
    install \
        -m 600 \
        -o "$USERNAME" \
        -g "$USERNAME" \
        "$PUBKEY" \
        "/home/$USERNAME/.ssh/authorized_keys"

    # Permission home
    chmod 755 "/home/$USERNAME"

done

echo "==================================" | tee -a "$LOGFILE"
echo "Berhasil membuat $TOTAL_USER user." | tee -a "$LOGFILE"
echo "Log tersimpan di $LOGFILE"
