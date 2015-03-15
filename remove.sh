#!/bin/bash

lwmDirectory=/opt/lwm

sesameImage=sesame_store
lwmImage=lwm_environment

sesameStoreDirectory=/opt/$sesameImage

sesameContainerAlias=sesame_db
lwmContainerAlias=lwm_web

dockerDBImage=`sudo docker images | awk '{print $1;}' | grep $sesameImage`
dockerServerImage=`sudo docker images | awk '{print $1;}' | grep $lwmImage`

dockerDBContainer=`sudo docker ps -a | awk '{print $12}' | grep $sesameContainerAlias`
dockerLWMContainer=`sudo docker ps -a | awk '{print $12}' | grep $lwmContainerAlias`

echo "Stopping LWM service"
sudo systemctl stop lwm_web.service
sudo systemctl stop lwm_db.service

sudo systemctl disable lwm_web.service
sudo systemctl disable lwm_db.service

sudo rm /lib/systemd/system/lwm_web.service
sudo rm /lib/systemd/system/lwm_db.service

echo "Checking containers"

if [ ! "$dockerDBContainer" = "" ]
then
	echo "Deleteing existing Sesame container"
	sudo docker stop -t 2 $sesameContainerAlias
	sudo docker rm -f $sesameContainerAlias
fi

echo "Removing Sesame host data directory"
	sudo rm -rf $sesameStoreDirectory

if [ ! "$dockerLWMContainer" = "" ]
then 
	echo "Deleting existing LWM container"

	sudo docker stop -t 2 $lwmContainerAlias
	sudo docker rm -f $lwmContainerAlias
fi

echo "Checking images"

if [ ! "$dockerServerImage" = "" ]
then
	echo "Removing LWM container image"
	#sudo docker rmi $lwmImage

	echo " "
else 
	echo "LWM container image already removed"
fi

if [ ! "$dockerDBImage" = "" ]
then
	echo "Removing sesame image"
	#sudo docker rmi $sesameImage 

	echo " "
else 
	echo "Sesame container image already removed"
fi

if [ -d $lwmDirectory ]
then 
	echo "Removing LWM directory"

	sudo rm -rf $lwmDirectory
else 
	echo "LWM directory already removed"
fi

echo " "
echo "Removal complete!"
