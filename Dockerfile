FROM deeson/fe-php:7.1

# Core tools
RUN apk --no-cache add \
    bash \
    coreutils \
    which \
    ca-certificates \
    openssh-client \
    patch \
    git \
    curl \
    unzip \
    make \
    rsync

COPY ./tools /opt/ci-tools
