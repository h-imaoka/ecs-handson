FROM python:alpine

ENV DOCKERIZE_VERSION v0.6.1

COPY app/ /app

RUN /bin/sh -c 'cd /app; \
pip install -r requirements.txt; \
wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz; \
tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz; \
rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz'

EXPOSE 5000/tcp

CMD ["/bin/sh", "-c", "/app/run.sh"]
