#!/bin/bash

set -e

setup_root() {
    # Set up the new root directory
    newroot=./root
    mkdir $newroot
    pkgs='archxlinux-keyring bash coreutils pacman ca-certificates'
    ignore_pkgs='cryptsetup,jfsutils,lvm2,mdadm,nano,netctl,reiserfsprogs,s-nail,vi,xfsprogs,man-pages,systemd'
    rm -rf /var/lib/pacman/db.lck
    yes | sudo pacman -Sy base-devel arch-install-scripts --noconfirm
    yes | pacstrap -i $newroot $pkgs --noconfirm --ignore $ignore_pkgs
    cp -r /etc/pacman* ./root/etc/

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

