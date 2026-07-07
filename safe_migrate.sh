#!/bin/bash

MAX_RETRIES=5
RETRIES_COUNT=0

until python manage.py migrate; do
    RETRIES_COUNT=$((RETRIES_COUNT+1))
    if [ $RETRIES_COUNT -ge $MAX_RETRIES ]; then
        echo "Migration failed. Maximum retries reached."
        exit 1
    fi
    echo "Migration failed. Retrying in 5 seconds... ($RETRIES_COUNT/$MAX_RETRIES)"
    sleep 5
done

exec python manage.py runserver 0.0.0.0:8080
