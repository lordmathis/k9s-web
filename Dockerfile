FROM alpine:3.23

ARG TARGET_ARCH

ARG TTYD_VERSION
ARG K9S_VERSION

RUN apk add --no-cache bash tini

# Install ttyd
ADD https://github.com/tsl0922/ttyd/releases/download/${TTYD_VERSION}/ttyd.x86_64  /usr/local/bin/ttyd
RUN chmod +x /usr/local/bin/ttyd

# Install k9s
ADD https://github.com/derailed/k9s/releases/download/v${K9S_VERSION}/k9s_linux_amd64.apk /tmp/k9s_linux_amd64.apk
RUN apk add --allow-untrusted /tmp/k9s_linux_amd64.apk

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["ttyd", "-W", "k9s"]