#!/bin/bash

# color schemes
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' 

# setup docker first
sudo bash ./setup_docker_ec2_cpu.sh

# # setup cortex
printf "${GREEN}\n\ninstalling cortex${NC}"
yes | bash -c "$(curl -sS https://raw.githubusercontent.com/cortexlabs/cortex/0.21/get-cli.sh)"


# # pull individual 3 repos
printf "${GREEN}\n\ncloning repos${NC}"
cd predictor_and_pdf_convert_setup
mkdir cortex-api
cd cortex-api
git clone https://github.com/read-what-you-need/pdf-to-text.git
git clone https://github.com/read-what-you-need/semantic-search-handler.git
git clone --recursive https://github.com/read-what-you-need/e2e-qg.git
cd ..
printf "${GREEN}\n\n 3/3 ✓ clone successful ${NC}"



# seed the environment variables in bashrc
printf "${GREEN}\n\nseed environment variables${NC}"
for d in cortex-api/*/; do sudo cp .env "$d"; done

# activate the api activation protocol
printf "${GREEN}\n\nLaunching cortex${NC}"
bash ./launch_cortex.sh


# set up crontab env

mkdir cron-jobs
cd cron-jobs
touch cron.output
touch cron.error
cd ..

# activate crontab
(crontab -l ;echo "* * * * * /bin/bash ~/scripts-ec2-setup/predictor_and_pdf_convert_setup/cortex-api-health-update.sh 1> ~/scripts-ec2-setup/predictor_and_pdf_convert_setup/cron-jobs/cron.output 2> ~/scripts-ec2-setup/predictor_and_pdf_convert_setup/cron-jobs/cron.error")| crontab -