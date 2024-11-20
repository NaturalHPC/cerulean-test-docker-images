#!/bin/bash

echo -e "\nstarting syslog-ng..."

if [ -p /dev/stdout ]; then
    sed -i 's/##SYSLOG_OUTPUT_MODE_DEV_STDOUT##/pipe/' /etc/syslog-ng/syslog-ng.conf
else
    sed -i 's/##SYSLOG_OUTPUT_MODE_DEV_STDOUT##/file/' /etc/syslog-ng/syslog-ng.conf
fi

syslog-ng

