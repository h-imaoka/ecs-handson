#!/bin/sh

cd /app

export FLASK_APP_REGION=${FLASK_APP_REGION:-us-west-2}
export FLASK_APP_DYNAMO_HOST=${FLASK_APP_DYNAMO_HOST:-http://172.17.0.1:8000}

if [ "${FLASK_APP_PRODUCTION:-undef}" = "undef" ];
then
    export AWS_ACCESS_KEY_ID=DYLOCAL
    export AWS_SECRET_ACCESS_KEY=dummy
    dockerize -wait ${FLASK_APP_DYNAMO_HOST}
else
    unset FLASK_APP_DYNAMO_HOST
fi

python shortener.py
