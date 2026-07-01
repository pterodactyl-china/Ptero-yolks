#!/bin/bash
# Set locale to Chinese (阿里云国内镜像)
export LANG=zh_CN.UTF-8
export LC_ALL=zh_CN.UTF-8
export LANGUAGE=zh_CN:zh

cd /home/container

#output current postgres version
postgres --version

# Make internal Docker IP address available to processes.
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP


function wait-port {
	local port=${1:-$SERVER_PORT}
	until nc -z 127.0.0.1 $port ; do
		sleep 1
	done
}


# Replace Startup Variables
MODIFIED_STARTUP=$(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
eval ${MODIFIED_STARTUP}

# Ensure the server has a clean exit
pg_ctl -D /home/container/postgres_db/ stop
