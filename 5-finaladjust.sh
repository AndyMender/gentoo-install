#!/bin/sh
# Final adjustments to the new boot environment
echo "Writing hostname to /etc/conf.d/hostname and /etc/hosts..."
nano -w /etc/conf.d/hostname
nano -w /etc/hosts

echo "Changing root password..."
passwd

read -p "Do you want to add users to the system?[y/n] " CHOICE
if [ $CHOICE = "y"]; then
	read -p "Login of the new user: " USERNAME
else
	exit
echo "Adding new user..."
useradd -m -g users -G audio,cdrom,games,usb,video,wheel,storage -s /bin/bash $USERNAME
passwd $USERNAME

echo "Adjusting extra configs..."
nano -w /etc/rc.conf
nano -w /etc/conf.d/keymaps
nano -w /etc/conf.d/hwclock

echo "Adding necessary daemons (dhcpcd, sshd, acpid, etc.)..."
cp /usr/share/dhcpcd/hooks/10-wpa_supplicant /lib/dhcpcd/dhcpcd-hooks

echo "Installation finished - please remove all scripts and the snapshot"
echo "tarball from the / directory. :)"
