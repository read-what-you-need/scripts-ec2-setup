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
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

printf "${GREEN}add repo for docke${NC}"
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get -y update
printf "${GREEN}install docke${NC}"
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose

sudo groupadd docker; sudo gpasswd -a $USER docker
printf "${GREEN}\n\ninstalling cortex${NC}"
$ bash -c "$(curl -sS https://raw.githubusercontent.com/cortexlabs/cortex/0.21/get-cli.sh)"