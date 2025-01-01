#!/bin/bash

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root"
    exit 1
fi

# System update
dnf update -y

# Install Samba
dnf install samba samba-common samba-client policycoreutils-python-utils -y

# Create share directory
mkdir -p /opt/share
chmod 770 /opt/share

# Backup original config
cp /etc/samba/smb.conf /etc/samba/smb.conf.bak

# Create Samba config
cat > /etc/samba/smb.conf << EOF
[global]
workgroup = WORKGROUP
security = user
map to guest = never
log file = /var/log/samba/log.%m
max log size = 50
dns proxy = no

[share]
path = /opt/share
valid users = samba
browseable = yes
writable = yes
read only = no
force create mode = 0660
force directory mode = 2770
guest ok = no
EOF

# Create system user
useradd -M -s /sbin/nologin samba
chown samba:samba /opt/share

# Create Samba user
(echo "samba"; echo "samba") | smbpasswd -s -a samba

# Set SELinux to permissive
setenforce 0
sed -i 's/SELINUX=enforcing/SELINUX=permissive/' /etc/selinux/config

# Configure SELinux for Samba
setsebool -P samba_enable_home_dirs on
setsebool -P samba_export_all_rw on
semanage fcontext -a -t samba_share_t "/opt/share(/.*)?"
restorecon -Rv /opt/share

# Configure firewall
firewall-cmd --permanent --add-service=samba
firewall-cmd --reload

# Start services
systemctl enable smb nmb
systemctl restart smb nmb

echo "Installation completed!"
echo "Samba share: \\\\<SERVER-IP>\\share"
echo "Username: samba"
echo "Password: samba"
echo "For security, change password with: smbpasswd samba"
