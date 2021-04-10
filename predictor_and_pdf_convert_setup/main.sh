#!/bin/bash


# setup docker first
sudo bash ./setup_docker_ec2_cpu.sh

# # setup cortex
bash -c "$(curl -sS https://raw.githubusercontent.com/cortexlabs/cortex/0.21/get-cli.sh)"

# # pull individual 3 repos
cd ..
mkdir cortex-api
cd cortex-api
git clone https://github.com/read-what-you-need/pdf-to-text.git
git clone https://github.com/read-what-you-need/semantic-search-handler.git
git clone -r https://github.com/read-what-you-need/e2e-qg.git
cd ..


# seed the environment variables in bashrc
export $(egrep -v '^#' .env | xargs)


# activate the api activation protocal
bash ./launch_cortex.sh


# set up crontab env
mkdir cron-jobs
touch cron.output
touch cron.error

# activate crontab
(crontab -l 2>/dev/null; echo "* * * * * /bin/bash ~/cortex-api-health-update.sh 1> ~/cron-jobs/cron.output 2> ~/cron-jobs/cron.error") | crontab -


