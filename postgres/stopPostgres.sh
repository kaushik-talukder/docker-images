#!/bin/bash

id=$(docker inspect -f {{.State.Running}} postgres || echo false)

if [ $id == true ]; then
  echo "Postgres Docker is running, stopping it now..."
  docker kill postgres
  docker rm postgres
else
  echo "Postgres Docker is not running"
fi