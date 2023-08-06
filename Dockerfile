FROM scratch
ADD rootfs.tar.xz /
CMD ["/bin/bash", "-c", "pacman -Sy base"]
