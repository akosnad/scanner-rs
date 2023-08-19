FROM alpine:latest

ARG USER_ID
ARG GROUP_ID

RUN apk add rustup bash git build-base libx11 gnupg
RUN passwd -d root; \
    addgroup -g ${GROUP_ID:-0} dev && adduser -u ${USER_ID:-0} -D -G dev -s /bin/bash dev

USER dev
RUN rustup-init -y \
    --default-host x86_64-unknown-linux-musl \
    --default-toolchain stable \
    --profile default \
    -t x86_64-unknown-linux-gnu

WORKDIR /workspace
