#!/bin/bash

echo -e "\nstarting sshd..."
/usr/sbin/sshd -De > /var/log/sshd.out.log 2> /var/log/sshd.err.log &

