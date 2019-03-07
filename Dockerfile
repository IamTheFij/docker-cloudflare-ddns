ARG REPO=library
FROM ${REPO}/python:3-alpine

ARG ARCH=x86_64
COPY ./build/qemu-${ARCH}-static /usr/bin/


RUN mkdir -p /src
WORKDIR /src

COPY ./requirements.txt ./
RUN pip install -r ./requirements.txt

COPY ./start.sh ./
COPY ./update_ddns.py ./update_ddns.py

ENV DOMAIN=""

CMD [ "/src/start.sh" ]
