FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Установка зависимостей и Suricata
RUN apt-get update && apt-get install -y \
    software-properties-common \
    curl gnupg lsb-release \
    ca-certificates \
    python3-pip \
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
    gettext && \
    add-apt-repository ppa:oisf/suricata-stable -y && \
    apt-get update && \
    apt-get install -y suricata && \
    apt-get clean

# Создание папки логов
RUN mkdir -p /var/log/suricata

# Рабочая директория
WORKDIR /etc/suricata

# Копируем финальный конфиг и правила
COPY suricata.yaml /etc/suricata/suricata.yaml
COPY rules /etc/suricata/rules

# Команда запуска
CMD ["suricata", "-c", "/etc/suricata/suricata.yaml"]

