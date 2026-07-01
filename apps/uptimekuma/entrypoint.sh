#!/bin/ash
# Set locale to Chinese (阿里云国内镜像)
export LANG=zh_CN.UTF-8
export LC_ALL=zh_CN.UTF-8
export LANGUAGE=zh_CN:zh

#System variables
clear
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Switch to the container's working directory
cd /home/container || exit 1

# Wait for the container to fully initialize
sleep 1

# Default the TZ environment variable to UTC.
TZ=${TZ:-UTC}
export TZ

# Set environment variable that holds the Internal Docker IP
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

# system informations
echo -e "${BLUE}-------------------------------------------------${NC}"
echo -e "${RED}Uptime Kuma Image${NC}"
echo -e "${BLUE}-------------------------------------------------${NC}"
echo -e "${YELLOW}Running on Alpine: ${RED} $(cat /etc/alpine-release)${NC}"
echo -e "${YELLOW}Current timezone: ${RED} ${TZ} ${NC}"
echo -e "${YELLOW}NodeJS Version: ${RED} $(node -v) ${NC}"
echo -e "${YELLOW}Cloudflared Version: ${RED} $(/usr/bin/cloudflared --version) ${NC}"
echo -e "${BLUE}-------------------------------------------------${NC}"

export PATH=$PATH:/root/.local/bin

# Replace Startup Variables
MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
eval ${MODIFIED_STARTUP}
