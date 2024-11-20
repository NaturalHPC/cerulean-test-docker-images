#!/bin/bash

. /etc/start-services/spack_locations.sh

hostname=$(hostname)

if [ $hostname == 'headnode' ] ; then
    echo -e "\nstarting mariadb..."

    . ${SPACK_LMOD}/lmod/lmod/init/bash

    module load mariadb
    setuser mysql mariadbd-safe >/var/log/mariadb.out.log 2>/var/log/mariadb.err.log &

    echo -n -e "\nwaiting for mariadb to start..."
    while ! nc -z localhost 3306 ; do
        sleep 1
        echo -n '.'
    done
    echo
fi

