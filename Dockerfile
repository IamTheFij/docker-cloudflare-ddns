ARG REPO=library

FROM multiarch/qemu-user-static:4.1.0-1 as qemu-user-static
# Make sure a dummy x86_64 file exists so that the copy command doesn't error
RUN touch /usr/bin/qemu-x86_64-fake

FROM ${REPO}/python:3-alpine

# Copy mutliarch file to run builds on x86_64
ARG ARCH=x86_64
COPY --from=qemu-user-static /usr/bin/qemu-${ARCH}-* /usr/bin/

RUN mkdir -p /src
WORKDIR /src

# Get Cloudflare example script
ENV CF_VERSION=2.6.0
ADD https://raw.githubusercontent.com/cloudflare/python-cloudflare/$CF_VERSION/examples/example_update_dynamic_dns.py ./update_ddns.py
RUN chmod +x ./update_ddns.py

RUN pip install --no-cache-dir cloudflare==$CF_VERSION

ENV DOMAIN=""

USER nobody

ENTRYPOINT [ "/src/update_ddns.py" ]
