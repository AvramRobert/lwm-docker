#!/bin/bash

dbService=lwm_db.service
webService=lwm_web.service

sudo systemctl disable $dbService
sudo systemctl disable $webService

echo "Stopping containers"
sudo docker stop -t 1 lwm_web
docker stop -t 1 sesame_db

echo "Removing containers"
docker rm -f lwm_webapp
docker rm -f sesame_db
