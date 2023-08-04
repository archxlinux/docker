#!/bin/bash

set -e

setup_root() {
    # Set up the new root directory
    newroot=./root

    # Set the mirrorlist to a local server
    echo 'Server = https://mirror.rackspace.com/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
    echo '[archx_repo]' >> /etc/pacman.d/mirrorlist 
    echo 'Server = https://archxlinux.com/$repo/$arch' >> /etc/pacman.d/mirrorlist



    pkgs='archxlinux-keyring bash coreutils'
    ignore_pkgs='cryptsetup,jfsutils,lvm2,mdadm,nano,netctl,reiserfsprogs,s-nail,vi,xfsprogs,man-pages,systemd,base-devel'
    pacstrap -i $newroot $pkgs --noconfirm --ignore $ignore_pkgs

    # Chroot into the new system
   #  arch-chroot $newroot /bin/bash
}

tar_rootfs() {
    # Create tar.xz of the new root filesystem
    cd $newroot
    tar -cJf ../rootfs.tar.xz *
    cd ..
}

create_dockerfile() {
    cat << EOF > Dockerfile
    FROM scratch
    ADD rootfs.tar.xz /
    CMD ["/bin/bash"]
EOF
}

build_docker_image() {
    docker build -t archxlinux .
}

# Call the functions
setup_root
tar_rootfs
create_dockerfile
build_docker_image

