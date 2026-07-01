#!/bin/ash
# Set locale to Chinese (阿里云国内镜像)
export LANG=zh_CN.UTF-8
export LC_ALL=zh_CN.UTF-8
export LANGUAGE=zh_CN:zh

#shellcheck shell=ash

echo "======================================================================"
echo "END OF LIFE:"
echo "This yolk is end-of-life and is no longer supported."
echo "Please migrate to a supported version"
echo "======================================================================"


# Wait for a signal or input to terminate the container
# This will prevent crash loops, allow the user time to see the error, and allow the container to be easily stopped.
read -r _
