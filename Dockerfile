FROM python:alpine

COPY app/ /app

RUN /bin/sh -c 'cd /app; \
pip install -r requirements.txt'

EXPOSE 5000/tcp

CMD ["/bin/sh", "-c", "/app/run.sh"]
