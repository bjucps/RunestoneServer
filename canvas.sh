#!/bin/bash

dbc="runestoneserver-db-1"

if ! docker inspect "$dbc" >/dev/null 2>&1; then
	echo "no '$dbc' container found; is the app running??"
	exit 1
fi

consumer=$(python3 -c "\
import secrets
print('bju-cps110-' + secrets.token_urlsafe(16))")

secret=$(python3 -c "\
import secrets
print(secrets.token_urlsafe(32))")

(docker exec -i "$dbc" psql -q -U runestone runestone <<EOF
insert into lti_keys (consumer, secret, application)
	values ('$consumer', '$secret', 'runestone');
EOF
) || (echo "FAILED"; exit 1)

echo "consumer: $consumer"
echo "secret:   $secret"
