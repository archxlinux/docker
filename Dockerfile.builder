FROM archxlinux/archxlinux
COPY build.sh /entrypoint.sh
RUN pacman -Sy base-devel --noconfirm

