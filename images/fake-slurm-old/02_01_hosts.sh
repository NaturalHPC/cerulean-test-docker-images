#!/bin/bash

hostname=$(hostname)

if [ $hostname == 'headnode' ] ; then
    if [ -n "$SELF_CONTAINED" ] ; then
        my_ip=$(grep ${hostname} /etc/hosts | cut -f 1)
        echo -n "$my_ip node-0 node-1 node-2 node-3 node-4" >>/etc/hosts
        echo -n " node-0.example.org node-1.example.org node-2.example.org" >>/etc/hosts
        echo -n " node-3.example.org node-4.example.org" >>/etc/hosts
    fi
fi

