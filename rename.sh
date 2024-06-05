#!/bin/bash

# Cek apakah script dijalankan sebagai root
if [ "$(id -u)" -ne 0 ]; then
    echo "Jalankan script ini sebagai root"
    exit 1
fi

# Cek apakah argumen hostname baru disediakan
if [ -z "$1" ]; then
    echo "Usage: $0 new_hostname"
    exit 1
fi

NEW_HOSTNAME=$1

# Ubah /etc/hostname
echo "$NEW_HOSTNAME" > /etc/hostname

# Ubah /etc/hosts
sed -i "s/127.0.1.1 .*/127.0.1.1 $NEW_HOSTNAME/" /etc/hosts

echo "Hostname berhasil diubah menjadi $NEW_HOSTNAME"

# Berikan pemberitahuan sebelum merestart sistem
echo "Sistem akan restart dalam 5 detik untuk menerapkan perubahan."
sleep 5

# Restart sistem
reboot
