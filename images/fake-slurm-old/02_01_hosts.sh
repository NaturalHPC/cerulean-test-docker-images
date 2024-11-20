#!/bin/bash

hostname=$(hostname)

if [ $hostname == 'headnode' ] ; then
    if [ -n "$SELF_CONTAINED" ] ; then
        my_ip=$(grep ${hostname} /etc/hosts | cut -f 1)
        echo "$my_ip node-0 node-1 node-2 node-3 node-4" >>/etc/hosts
    fi
fi

