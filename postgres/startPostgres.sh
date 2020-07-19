#!/bin/bash
id=$(docker inspect -f {{.State.Running}} postgres || echo false)

if [ $id == true ]; then
  echo "Postgres Docker is running, stopping it now..."
  docker kill postgres
  docker rm postgres
else
  echo "Postgres Docker is not running"
fi

docker run --name postgres -e POSTGRES_PASSWORD=admin -d -p 5432:5432 postgres:12.3

sleep 5

docker cp scripts postgres:/
docker exec -it postgres psql -U postgres -a -f /scripts/schema.sql
docker exec -it postgres psql -U postgres -a -f /scripts/data.sql

echo "Postgres Docker Initialization Complete"