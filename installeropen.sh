#!/bin/bash

# Update the system
apt update && apt upgrade -y

# Install Docker
echo ''
echo ''
echo 'Install Docker'
sleep 1
apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

apt-key fingerprint 0EBFCD88

add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

apt update

apt install -y docker-ce docker-ce-cli containerd.io

echo ''
echo ''

sleep 5

echo ''
echo ''

# Make a Data Directory for Subspace
echo ''
echo ''
echo 'Make a Data Directory for Subspace'
echo ''
sleep 1

mkdir /data

# Create and Pull the Docker Subspace Container

echo ''
echo 'Give your domain name (FQDN) or IP address for your subspace server:'
read subspaceName

docker create \
--name subspace \
--restart always \
--network host \
--cap-add NET_ADMIN \
--volume /usr/bin/wg:/usr/bin/wg \
--volume /data:/data \
--env SUBSPACE_HTTP_HOST=$subspaceName \
subspacecloud/subspace:latest

sleep 3
echo ''
echo ''
echo 'Waiting for Container Creation to complete in 20s'
echo ''
echo ''
sleep 20

# Start the Docker Container
echo 'Starting the Subspace Container'
echo ''
echo ''
sleep 1

docker start subspace
