FROM scratch
ADD rootfs.tar.zst /

# Uncomment only the first "Server =" line after "## Worldwide"
RUN sed -i '/## Worldwide/{n;s/^#//;}' /etc/pacman.d/mirrorlist

# Add [archx] repository to pacman.conf
RUN echo -e '\n[archx]\nSigLevel = Optional TrustedOnly\nServer = http://archxlinux.dev/repository/$arch' >> /etc/pacman.conf

RUN pacman-key --init && pacman-key --populate && pacman-key --refresh-keys
RUN yes | LC_ALL=en_US.UTF-8 pacman -Sy archxlinux-keyring --noconfirm
# Ensure pacman syncs with the new repo
CMD ["/bin/bash"]
