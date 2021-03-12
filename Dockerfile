FROM alpine:3.12.1

# Install needed packages
RUN    apk update && apk add openssl easy-rsa openvpn iptables bash openssl-dev python3-dev py3-pip libffi-dev build-base git && \
    mkdir /etc/openvpn/tmp && \
    chown nobody:nobody /etc/openvpn/tmp && \
    cd /tmp && \
    git clone https://github.com/NextDeveloperTeam/okta-openvpn.git && \
    cd okta-openvpn && \
    git checkout python3 && \
    pip install -r requirements.txt && \
    make && \
    make install && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

# Configure tun
RUN mkdir -p /dev/net && \
    mknod /dev/net/tun c 10 200

# Configure okta-openvpn
COPY okta_openvpn.ini /etc/openvpn/okta_openvpn.ini
