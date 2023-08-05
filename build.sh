#!/bin/bash

set -e

setup_root() {
    # Set up the new root directory
    newroot=./root
    mkdir -p $newroot

    pkgs='archxlinux-keyring bash coreutils'
    ignore_pkgs='cryptsetup,jfsutils,lvm2,mdadm,nano,netctl,reiserfsprogs,s-nail,vi,xfsprogs,man-pages,systemd,base-devel'
    yes | pacman -Sy base-devel arch-install-scripts --noconfirm
    yes | pacstrap -i $newroot $pkgs --noconfirm --ignore $ignore_pkgs

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

