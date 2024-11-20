#!/bin/bash

if [ -f /etc/start-services/slurm_version.sh ] ; then
    . /etc/start-services/slurm_version.sh
fi

. /etc/start-services/spack_locations.sh
SLURM_LOCATION_VAR="SPACK_SLURM_${SLURM_VERSION/-/_}"

hostname=$(hostname)

if [ $hostname == 'headnode' ] ; then
    . ${SPACK_LMOD}/lmod/lmod/init/bash

    echo -e "\nstarting slurmdbd..."
    ${!SLURM_LOCATION_VAR}/sbin/slurmdbd -D >/var/log/slurmdbd.out.log 2>/var/log/slurmdbd.err.log &

    echo -n -e "\nwaiting for slurmdbd to start..."
    while ! nc -z localhost 6819 ; do
        sleep 1
        echo '.'
    done
    echo
fi

