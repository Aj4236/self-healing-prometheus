#!/bin/bash
# Live demo for self-healing NGINX

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

while true; do
    echo -e "${YELLOW}Stopping NGINX container...${NC}"
    sudo docker stop nginx 2>/dev/null || echo "NGINX already stopped"

    echo -e "${YELLOW}Waiting 30 seconds for Prometheus/Alertmanager to trigger...${NC}"
    sleep 30

    echo -e "${GREEN}Checking NGINX status:${NC}"
    sudo docker ps | grep nginx || echo -e "${RED}NGINX not running yet!${NC}"

    echo -e "${GREEN}Webhook + Ansible Logs:${NC}"
    sudo docker logs --tail 20 ansible-webhook

    echo -e "${YELLOW}-----------------------------------------------${NC}"
    sleep 10
done

