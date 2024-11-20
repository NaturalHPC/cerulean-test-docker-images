#!/bin/bash

(

while [ 1 ] ; do
    sleep $(( ( RANDOM % 20 ) + 10 ))
    PIDS=$(ps auwx | grep 'sshd: cerulean' | cut -c 10-16)
    for PID in $PIDS ; do
        if [ $(( RANDOM % 8)) = '0' ] ; then
            kill $PID >/dev/null 2>&1
        fi
    done
    echo -n 'Dropped SSH connections '
    date
done

) >/var/log/flaky.txt &

