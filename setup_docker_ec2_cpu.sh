#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' 

sudo apt-get -y update
printf "${GREEN}update libraries required for docker${NC}"

sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

printf "${GREEN}download docker and add it's keys${NC}"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

printf "${GREEN}add repo for docker${NC}"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
printf "${GREEN}install docke${NC}"
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose

sudo gpasswd -a $USER docker
sudo chmod 777 /var/run/docker.sock