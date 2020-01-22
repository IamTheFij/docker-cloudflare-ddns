ARG REPO=library
FROM ${REPO}/python:3-alpine

# TODO: Copy from docker hub image
ARG ARCH=x86_64
COPY ./build/qemu-${ARCH}-static /usr/bin/

RUN mkdir -p /src
WORKDIR /src

# Get Cloudflare example script
ENV CF_VERSION=2.6.0
ADD https://raw.githubusercontent.com/cloudflare/python-cloudflare/$CF_VERSION/examples/example_update_dynamic_dns.py ./update_ddns.py
RUN chmod +x ./update_ddns.py

RUN pip install cloudflare==$CF_VERSION

ENV DOMAIN=""

USER nobody

ENTRYPOINT [ "/src/update_ddns.py" ]
