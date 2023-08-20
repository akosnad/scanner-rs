FROM rust:latest

ARG USER_ID
ARG GROUP_ID

# needed packages
RUN apt update && apt install -y sudo

# dev user
RUN passwd -d root; \
    echo '%dev ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers; \
    groupadd -g ${GROUP_ID:-0} dev && useradd -m -u ${USER_ID:-0} -g dev -s /bin/bash dev

# rust toolchain
RUN sudo -u dev bash -c "echo 'export PATH=/usr/local/cargo/bin:$PATH' >> /home/dev/.bashrc"
RUN rustup default stable && rustup component add rustfmt

# additional packages
RUN apt install -y bash git gnupg libwayland-dev weston dmz-cursor-theme && \
    apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

USER dev
WORKDIR /workspace
