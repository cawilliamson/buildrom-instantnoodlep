FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive
ENV GIT_SSH_COMMAND "ssh -i /var/tmp/buildrom/includes/common/id_rsa -o StrictHostKeyChecking=no"
ENV HOME /var/tmp
ENV LC_ALL C
ENV TARGET_BUILD_VARIANT user

RUN apt update && apt -y --no-install-recommends install \
  bc \
  bison \
  build-essential \
  curl \
  flex \
  gcc-multilib \
  git \
  gnupg \
  gperf \
  g++-multilib \
  imagemagick \
  iputils-ping \
  lib32ncurses5-dev \
  lib32z1-dev \
  libbz2-dev \
  libc6-dev-i386 \
  libffi-dev \
  libghc-bzlib-dev \
  libgl1-mesa-dev \
  libjpeg8-dev \
  liblz4-tool \
  libssl-dev \
  libx11-dev \
  libxml2-dev \
  libxml2-utils \
  libxslt1-dev \
  lzop \
  openjdk-8-jdk \
  openssh-server \
  optipng \
  pngcrush \
  python \
  python3 \
  rsync \
  schedtool \
  squashfs-tools \
  unzip \
  x11proto-core-dev \
  xsltproc \
  zip \
  zlib1g-dev && rm -rf /var/lib/apt/lists/*

RUN git config --global user.email "root@localhost"
RUN git config --global user.name "Docker Container"

RUN curl https://bootstrap.pypa.io/get-pip.py | python && pip install networkx
RUN curl -L -o /usr/bin/repo http://commondatastorage.googleapis.com/git-repo-downloads/repo && chmod +x /usr/bin/repo

RUN mkdir -p /usr/src/rom

ENTRYPOINT [ "bash", "/var/tmp/buildrom/includes/common/init.sh" ]
