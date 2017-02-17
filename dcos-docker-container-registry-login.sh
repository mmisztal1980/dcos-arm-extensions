#!/bin/bash
# Author: mmisztal1980
#
# This script will generate the docker.tar.gz in /etc/docker.tar.gz containing
# sign-in information for a single custom container registry, for usage with DCOS   
#
# Usage: ./dcos-docker-container-registry-login.sh --registry={REGISTRY} --username={USERNAME} --password={PASSWORD}


for i in "$@"
do
case $i in
    -r=*|--registry=*)
    REGISTRY="${i#*=}"
    ;;
    -u=*|--username=*)
    USERNAME="${i#*=}"
    ;;
    -p=*|--password=*)
    PASSWORD="${i#*=}"
    ;;
esac
done

# Attempt to login to the private container registry
docker login --username ${USERNAME} --password ${PASSWORD} ${REGISTRY}

if [ $? -eq 0 ]
then
  tar -cvzf /etc/docker.tar.gz ~/.docker
else
  echo "Failed to login to the docker registry"
  exit 1
fi