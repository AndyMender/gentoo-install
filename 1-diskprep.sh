#!/bin/sh
# Short script to define drives to be formatted and prepared
# for installation

echo "The drive(s) will be now prepared for installation..."
echo "If partitions were NOT created via fdisk/cfdisk/etc,"
echo "TERMINATE THE SCRIPT AND DO SO NOW!"

read -p "The full path to the BOOT partition: " BOOT_PART
read -p "File system for the BOOT partition: " BOOT_FS
read -p "The full path to the ROOT partition: " ROOT_PART
read -p "File system for the ROOT partition: " ROOT_FS
read -p "The full path to the SWAP partition: " SWAP_PART
read -p "The full path to the HOME partition: " HOME_PART
read -p "File system for the HOME partition: " HOME_FS

echo "Here are the selections you have made:"
echo "$BOOT_PART will be formatted to $BOOT_FS"
echo "$ROOT_PART will be formatted to $ROOT_FS"
echo "$SWAP_PART will be formatted to swap (duh)!"
echo "$HOME_PART will be formmated to $HOME_FS"

read -p "Press y to continue. " CHOICE
if [ $CHOICE = "y" ]; then
	continue
else
	exit
fi

echo "Formatting partitions..."
mkfs.$BOOT_FS $BOOT_PART
mkfs.$ROOT_FS $ROOT_PART
mkswap $SWAP_PART
mkfs.$HOME_FS $HOME_PART

echo "Mounting partitions..."
mkdir /mnt/gentoo
mount $ROOT_PART /mnt/gentoo
mkdir /mnt/gentoo/boot
mount $BOOT_PART /mnt/gentoo/boot
mkdir /mnt/gentoo/home
mount $HOME_PART /mnt/gentoo/home
swapon $SWAP_PART

echo "Disk(s) prepared and partitions mounted successfully :)."
