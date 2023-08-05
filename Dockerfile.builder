FROM archxlinux/archxlinux
COPY build.sh /entrypoint.sh
RUN pacman -Sy arch-install-scripts --noconfirm

