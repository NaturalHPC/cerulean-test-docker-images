#!/bin/bash
echo -e "\nstarting syslog-ng..."
syslog-ng

echo -e "\nstarting munged..."
setuser munge /usr/sbin/munged --foreground > /var/log/munged.out.log 2> /var/log/munged.err.log &

echo -n -e "\nwaiting for munged to start..."
while [ ! -e /run/munge/munge.socket.2 ] ; do
    sleep 1
    echo '.'
done
echo

echo -e "\nstarting slurmctld..."
/usr/local/sbin/slurmctld -D -c -vvvv > /var/log/slurmctld.out.log 2> /var/log/slurmctld.err.log &

echo -n -e "\nwaiting for slurmctld to start..."
while ! nc -z localhost 6817 ; do
    sleep 1
    echo '.'
done
echo

echo -e "\nstarting compute nodes..."
/usr/local/sbin/slurmd -D -N node-0 > /var/log/slurmd-node-0.out.log 2> /var/log/slurmd-node-0.err.log &
/usr/local/sbin/slurmd -D -N node-1 > /var/log/slurmd-node-1.out.log 2> /var/log/slurmd-node-1.err.log &
/usr/local/sbin/slurmd -D -N node-2 > /var/log/slurmd-node-2.out.log 2> /var/log/slurmd-node-2.err.log &
/usr/local/sbin/slurmd -D -N node-3 > /var/log/slurmd-node-3.out.log 2> /var/log/slurmd-node-3.err.log &
/usr/local/sbin/slurmd -D -N node-4 > /var/log/slurmd-node-4.out.log 2> /var/log/slurmd-node-4.err.log &

echo -e "\nmaking accounting readable to users..."
/bin/chmod -R og+rX /var/log/slurm

echo -e "\nstarting sshd..."
/usr/sbin/sshd -De > /var/log/sshd.out.log 2> /var/log/sshd.err.log &

echo -e "\nStartup complete"

sleep infinity

