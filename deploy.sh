#!/bin/bash

lwmDirectory=/opt/lwm
lwmGit=https://github.com/FHK-ADV/lwm

lwmDBService=lwm_db.service
lwmWebService=lwm_web.service

sesameImage=sesame_store
lwmImage=lwm_environment

sesameStoreDirectory=/opt/$sesameImage

sesameContainerAlias=sesame_db
lwmContainerAlias=lwm_web

dockerDBImage=`sudo docker images | awk '{print $1;}' | grep $sesameImage`
dockerServerImage=`sudo docker images | awk '{print $1;}' | grep $lwmImage`

dockerDBContainer=`sudo docker ps -a | awk '{print $12}' | grep $sesameContainerAlias`
dockerLWMContainer=`sudo docker ps -a | awk '{print $12}' | grep $lwmContainerAlias`

echo " "
echo "Starting docker service"
sudo systemctl start docker

./remove.sh

if [ ! -d $lwmDirectory ]
then 
	echo "LWM directory not found. Pulling from github.."

	#sudo git clone $lwmGit $lwmDirectory

fi

if [ "$dockerDBImage" = "" ]
then
	echo " "
	echo "Sesame image not found"
	echo "Building Sesame container image"
	
	#sudo docker build -t $sesameImage ./sesame/.
fi

if [ "$dockerServerImage" = "" ]
then
	echo " "
	echo "LWM app container image not found"
	echo "Building LWM webapp container image"

	#sudo docker build -t $lwmImage ./lwm/.
fi

echo "Creating Sesame host data directory"
#sudo mkdir $sesameStoreDirectory
 
echo " "
echo "Setting up LWM services"
#sudo cp ./units/$lwmDBService /lib/systemd/system/
#sudo cp ./units/$lwmWebService /lib/systemd/system/

echo "Starting LWM services"
#sudo systemctl enable $lwmDBService
#sudo systemctl enable $lwmWebService

#gnome-terminal -x bash -c "sudo systemctl start $lwmDBService"
#sudo systemctl start $lwmWebService
