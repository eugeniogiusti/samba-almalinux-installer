# samba-almalinux-installer
A bash script for automated Samba server installation and configuration on AlmaLinux 9.5

# Introduction

This script automates the setup and configuration of a Samba file server on a Linux machine. It is designed for Almalinux 9.5, but can be adapted for other Red Hat distributions. It is suitable for various environments, such as Raspberry Pi, virtual machines, or physical servers.

# Features

- Installs and configures Samba.

- Creates a shared directory (/opt/share).

- Sets up a dedicated Samba user.

- Configures SELinux and firewall rules for Samba.

- Provides a secure and easily customizable setup.

# Prerequisites

- A Linux system with DNF package manager.

- Root privileges to execute the script.

- VM with 2core, 2gb ram, 32gb hdd/ssd


## How to Run the Script

1. Update the system
   ```bash
   sudo su
   dnf update -y
   dnf install git

2. Clone the repository:
   ```bash
   git clone https://github.com/eugeniogiusti/samba-almalinux-installer.git
   cd samba-almalinux-installer


3. Make the script executable:
   ```bash
   chmod +x samba.sh


4. Run the script as root:
   ```bash
   sudo ./samba.sh


5. Access to the share:

![image](https://github.com/user-attachments/assets/2ae12d3e-6083-4d9f-8aa3-10fc91fd546e)

![image](https://github.com/user-attachments/assets/d0895469-5af9-42ff-a812-a8255bd0a95b)

![image](https://github.com/user-attachments/assets/495f35c9-5d05-47de-a2f6-c748581ce73a)

   ```bash
   \\<SERVER-IP>\share   # for Windows machine
   smb://<SERVER-IP>/share # for Linux machine
   Username: samba
   Password: samba (Change it using smbpasswd samba).
   
