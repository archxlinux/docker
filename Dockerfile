FROM scratch
ADD rootfs.tar.xz /
CMD ["/bin/bash", "-c", "pacman-key --recv-keys DA6BDDD08D26A04AAC997968C79769BC07914012"]
