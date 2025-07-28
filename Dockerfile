FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    software-properties-common \
    curl gnupg lsb-release \
    ca-certificates \
    python3-pip \
    sudo \
    libpcap-dev \
    libpcre3-dev \
    libyaml-dev \
    zlib1g-dev \
    libmagic-dev \
    build-essential \
    libnet1-dev \
    libcap-ng-dev \
    libjansson-dev \
    libnss3-dev \
    libgeoip-dev \
    liblua5.1-dev \
    wget \
    git \
    vim \
    tzdata \
    iproute2 \
    net-tools \
    nano \
    gettext

RUN add-apt-repository ppa:oisf/suricata-stable -y && \
    apt-get update && \
    apt-get install -y suricata

RUN mkdir -p /var/log/suricata

WORKDIR /etc/suricata

COPY suricata.template.yaml /etc/suricata/suricata.template.yaml
COPY rules /etc/suricata/rules
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
