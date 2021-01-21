ARG REPO=library

FROM multiarch/qemu-user-static:4.2.0-2 as qemu-user-static
# Make sure a dummy x86_64 file exists so that the copy command doesn't error
# RUN touch /usr/bin/qemu-x86_64-fake

FROM ${REPO}/python:3-slim

# Copy mutliarch file to run builds on x86_64
ARG ARCH=x86_64
COPY --from=qemu-user-static /usr/bin/qemu-* /usr/bin/
# COPY --from=qemu-user-static /usr/bin/qemu-${ARCH}-* /usr/bin/

RUN mkdir -p /src
WORKDIR /src

# Get Cloudflare example script
ENV CF_VERSION=2.8.15
ADD https://raw.githubusercontent.com/cloudflare/python-cloudflare/$CF_VERSION/examples/example_update_dynamic_dns.py ./update_ddns.py
RUN chmod +rx ./update_ddns.py

RUN python -m pip install -U setuptools
RUN python -m pip install --no-cache-dir cloudflare==$CF_VERSION

ENV DOMAIN=""

USER nobody

ENTRYPOINT [ "/src/update_ddns.py" ]
