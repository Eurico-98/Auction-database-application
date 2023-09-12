#!/bin/bash

image="bd-psql"
container="db"

echo "-- Building --"
docker   build  -t  $image   .
