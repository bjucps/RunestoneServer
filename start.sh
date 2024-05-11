#!/bin/bash

base="$(dirname $0)"

export RUNESTONE_HOST=cps110book.bjucps.dev
export POSTGRES_PASSWORD=$(cat "$base/.pgpasswd")

cd "$base"
docker compose up -d

