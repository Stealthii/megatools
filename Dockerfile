FROM ubuntu:xenial
MAINTAINER Dan Porter <dpreid@gmail.com>

ENV BUILD_PACKAGES "build-essential autoconf automake pkg-config libtool libglib2.0-dev libssl-dev libcurl4-gnutls-dev wget ca-certificates"

RUN set -x \
    && apt-get update && apt-get install -y --no-install-recommends $BUILD_PACKAGES \
    && mkdir -p /tmp/build \
    && wget -O /tmp/build/megatools.tar.gz https://github.com/megous/megatools/archive/master.tar.gz \
    && tar -xzf /tmp/build/megatools.tar.gz -C /tmp/build/ \
    && cd /tmp/build/megatools-master \
    && ./autogen.sh --disable-docs \
    && make install \
    && cd / \
    && rm -rf /tmp/build \
    && apt-get purge -y $BUILD_PACKAGES \
    && apt-get install -y --no-install-recommends \
        libgio2.0 \
        libcurl3-gnutls \
        libssl1.0.0 \
        ca-certificates \
    && apt-get autoremove -y --purge \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /data

CMD ["megadl"]
