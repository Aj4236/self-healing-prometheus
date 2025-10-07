#!/bin/bash

# Demo script: Auto-healing NGINX continuously

# Colors for output
GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m"

# 1. Ensure NGINX container exists
if [ "$(sudo docker ps -a -q -f name=nginx)" ]; then
    echo -e "${GREEN}Removing existing NGINX container...${NC}"
    sudo docker rm -f nginx
fi

echo -e "${GREEN}Starting NGINX container...${NC}"
sudo docker run -d --name nginx -p 8080:80 nginx:stable-alpine

# 2. Tail ansible-webhook logs in background
echo -e "${GREEN}Tailing webhook logs...${NC}"
sudo docker logs -f ansible-webhook &
LOGS_PID=$!

# 3. Continuous stop/start to trigger auto-healing
while true; do
    echo -e "${RED}Stopping NGINX to trigger auto-healing...${NC}"
    sudo docker stop nginx
    sleep 40   # wait for Prometheus alert to fire & webhook to run Ansible

    echo -e "${GREEN}Checking NGINX status...${NC}"
    sudo docker ps | grep nginx || echo -e "${RED}NGINX is not running yet!${NC}"

    echo -e "${GREEN}Waiting 20 seconds before next cycle...${NC}"
    sleep 20
done

# Cleanup: stop tailing logs on script exit
trap "kill $LOGS_PID; exit" SIGINT SIGTERM

