#!/bin/bash

set -e

setup_root() {
    # Set up the new root directory
    newroot=./root
    mkdir -p $newroot

    pkgs='archxlinux-keyring bash coreutils'
    ignore_pkgs='cryptsetup,jfsutils,lvm2,mdadm,nano,netctl,reiserfsprogs,s-nail,vi,xfsprogs,man-pages,systemd,base-devel'
    pacman -Sy base-devel --noconfirm
    /usr/bin/pacstrap -i $newroot $pkgs --noconfirm --ignore $ignore_pkgs

    # Chroot into the new system
   #  arch-chroot $newroot /bin/bash
}

tar_rootfs() {
    # Create tar.xz of the new root filesystem
    cd $newroot
    tar -cJf ../rootfs.tar.xz *
    cd ..
}

setup_root
tar_rootfs


sudo rm -rf ./root

