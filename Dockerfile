FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
  dumb-init \
  curl \
  dante-server \
  stunnel4 && \
# Clean up apt cache
  rm -rf /var/lib/apt/lists/*

RUN useradd -r proxy_username

COPY ./danted.conf /etc/danted.conf
COPY ./proxyTLS.conf /etc/stunnel/proxyTLS.conf
COPY ./init.sh /opt/init.sh

EXPOSE 1080
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/opt/init.sh"]