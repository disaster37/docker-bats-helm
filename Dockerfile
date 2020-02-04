FROM bats/bats:latest
MAINTAINER Sebastien LANGOUREAUX (linuxworkgroup@hotmail.com)

ARG http_proxy
ARG https_proxy

# Set environment
ENV HELM_VERSION=v2.16.1 \
    KUBECTL_VERSION=v1.17.0

# Add Python and JQ
RUN \
    apk --update add python3 curl jq &&\
    rm -rf /var/cache/apk/* &&\
    pip3 install yq


# Add helm cli
RUN \
    curl -fL https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -o /tmp/helm.tar.gz &&\
    tar -xvzf /tmp/helm.tar.gz -C /tmp &&\
    mv /tmp/linux-amd64/helm /usr/bin/

# Add kube cli
RUN \
    curl -fL https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/bin/kubectl &&\
    chmod +x /usr/bin/kubectl


# Clean image
RUN \
    rm -rf /var/cache/apk/* &&\
    rm -rf /tmp/*

