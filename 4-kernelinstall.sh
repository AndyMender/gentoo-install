#!/bin/sh
# Builds and installs kernel based on previously transferred .config

echo "Preparing kernel sources and building kernel..."
cd /usr/src/linux
make menuconfig
MAKEOPTS="-j3" make && make modules_install
make install

echo "Building initramfs with genkernel..."
genkernel --install initramfs

echo "Installing and configuring GRUB2 bootloader..."
grub-install --target=x86_64-efi --efi-directory=/boot --boot-directory=/boot --bootloader-id=grub
grub-mkconfig -o /boot/grub/grub.cfg

echo "Kernel and initramfs built, bootloader configured successfully. :)" 
