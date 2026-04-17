FROM ubuntu:24.04

LABEL MAINTAINER="qcgzxw<qcgzxw.com@gmail.com>"
ARG DEBIAN_FRONTEND=noninteractive

# Set Environment Variables
ENV APP_MODE=dev \
    MAX_SEND_LIMIT=10 \
    FORMAT=epub \
    EMAIL_PROVIDER=config \
    DB=sqlite \
    DB_NAME=/app/storage/ebook-sender-bot.db \
    DB_HOST=localhost \
    DB_PORT=3306 \
    DB_USER=root \
    DB_PASSWORD=root \
    SMTP_HOST= \
    SMTP_PORT= \
    SMTP_USERNAME= \
    SMTP_PASSWORD= \
    MAILCOW_URL= \
    MAILCOW_API_KEY= \
    MAILCOW_MAILBOX_DOMAIN= \
    BOT_TOKEN= \
    DEVELOPER_CHAT_ID= \
    PIP_BREAK_SYSTEM_PACKAGES=1

# Install Calibere And Python
RUN \
  set -eux; \
  apt_packages="ca-certificates curl pkg-config tzdata wget xz-utils iputils-ping git libfontconfig1 libgl1 libnss3 libopengl0 libxcb-cursor0 python3 python3-pip python3-pyqt5.qtmultimedia python3-pyqt5.qtwebengine"; \
  attempt=0; \
  until [ "${attempt}" -ge 3 ]; do \
    if apt-get update -o Acquire::Retries=5 -o Acquire::http::Timeout=30 -o Acquire::https::Timeout=30 \
      && apt-get install -y --no-install-recommends --fix-missing ${apt_packages}; then \
      break; \
    fi; \
    attempt=$((attempt + 1)); \
    if [ "${attempt}" -ge 3 ]; then \
      exit 1; \
    fi; \
    rm -rf /var/lib/apt/lists/*; \
    sleep 5; \
  done; \
  rm -rf /var/lib/apt/lists/*

RUN \
  wget --no-check-certificate -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sh /dev/stdin && \
  rm -rf /var/lib/apt/lists/*

# Setup App
WORKDIR /app
VOLUME ["/app/storage"]
COPY . .
RUN \
  chmod +x docker/setup.sh && \
  mkdir -p /app/storage && \
  pip3 install -r requirements.txt && \
  touch /app/storage/default.log

# Run App
CMD ["/bin/bash", "/app/docker/setup.sh"]
