#!/bin/sh
# Final adjustments to the new boot environment

echo "Below steps have to be performed manually..."
echo "nano -w /etc/conf.d/hostname"
echo "nano -w /etc/hosts"
echo "passwd"
echo "useradd -m -g users -G audio,cdrom,games,usb,video,wheel,storage -s /bin/bash <username>"
echo "Adjusting the sudoers file to allow superuser access"
echo "passwd <username>"
echo "nano -w /etc/rc.conf"
echo "nano -w /etc/conf.d/keymaps"
echo "nano -w /etc/conf.d/hwclock"
echo "Adding necessary daemons (dhcpcd, sshd, acpid, etc.)"
cp /usr/share/dhcpcd/hooks/10-wpa_supplicant /lib/dhcpcd/dhcpcd-hooks

echo "Installation finished - please remove all scripts and the snapshop"
echo "tarball from the / directory. :)"
