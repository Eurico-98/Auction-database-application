#!/bin/bash
image="bd-psql"
container="db"



docker stop $container
docker rm $container