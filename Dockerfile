FROM python:3-alpine

RUN mkdir -p /src
WORKDIR /src

COPY ./requirements.txt ./
RUN pip install -r ./requirements.txt

COPY ./start.sh ./
COPY ./update_ddns.py ./update_ddns.py

ENV DOMAIN=""

CMD [ "/src/start.sh" ]
