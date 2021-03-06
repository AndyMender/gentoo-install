#!/bin/sh
# Download, extract the snapshop and prepare the chroot environment
read -p "Snapshop date in YYYYMMDD format: " DATE
CHROOT=/mnt/gentoo
cd $CHROOT

echo "Getting and extracting and the snapshot tarball..."
wget http://gentoo.osuosl.org/releases/amd64/autobuilds/$DATE/stage3-amd64-${DATE}.tar.bz2 
tar xjpf stage3-*.tar.bz2 --xattrs

echo "Copying make.conf to new environment..."
mkdir $CHROOT/etc/portage
mkdir $CHROOT/etc/portage/package.use
cp /root/gentoo-install/make.conf $CHROOT/etc/portage/make.conf
cp /root/gentoo-install/useflag-selection $CHROOT/etc/portage/package.use/useflag-selection

echo "Creating repository .conf file..."
mkdir $CHROOT/etc/portage/repos.conf
cp $CHROOT/usr/share/portage/config/repos.conf $CHROOT/etc/portage/repos.conf/gentoo.conf

echo "Copying resolv.conf from host system..."
cp -L /etc/resolv.conf $CHROOT/etc/

echo "Mounting devices and additional file systems..."
mount -t proc proc $CHROOT/proc
mount --rbind /sys $CHROOT/sys
mount --make-rslave $CHROOT/sys
mount --rbind /dev $CHROOT/dev
mount --make-rslave $CHROOT/dev

echo "Copying chroot adjustment scripts to chroot environment..."
cp /root/gentoo-install/3-chrootadjust.sh $CHROOT
cp /root/gentoo-install/4-kernelinstall.sh $CHROOT
cp /root/gentoo-install/5-finaladjust.sh $CHROOT
cp /root/gentoo-install/kernel-config $CHROOT
cp /root/gentoo-install/fstab $CHROOT/etc/fstab
cp /root/gentoo-install/wpa_supplicant.conf $CHROOT/etc/wpa_supplicant

echo "Chroot environment prepared successfully. :)"
