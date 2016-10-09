#!/bin/sh
# Be sure to execute the below commands before launching this script!
# CHROOT=/mnt/gentoo
# chroot $CHROOT /bin/bash
# source /etc/profile
# export PS1="(chroot) $PS1"

# *All of the below commands are executed within the chroot
# *environment!
echo "First-time Portage tree sync..."
emerge-webrsync

echo "Second-time Portage tree re-sync..."
emerge --sync --quiet

echo "Selecting desktop system profile..."
# The profile will not matter much later, because make.conf
# overwrites all USE flags via "*-"
eselect profile list
eselect profile set 2

echo "Adjusting world set to new profile..."
emerge --ask --update --deep --newuse --quiet-build @world

# Below packages will be needed later
emerge --newuse --deep gentoo-sources sys-boot/grub:2 pciutils genkernel linux-firmware syslog-ng mlocate xfsprogs e2fsprogs dosfstools dhcpcd 
echo "Moving kernel .config to /usr/src/linux symlinked directory..."
cp ./kernel-config /usr/src/linux

echo "Defining timezone data..."
echo "Europe/Vienna" > /etc/timezone
emerge --config sys-libs/timezone-data

echo "Configuring locale(s)..."
nano -w /etc/locale.gen
locale-gen

echo "Selecting locale(s)..."
eselect locale list
eselect locale set 5

echo "Updating environment..."
env-update && source /etc/profile && export PS1="(chroot) $PS1"

echo "Environment adjustments completed. :)"
echo "IF ANY OF THE ESELECT PROFILES ARE INCORRECT, PLEASE REDO"
echo "THE NECESSARY STEPS!"
