#!/bin/bash

if [ -f /etc/start-services/slurm_version.sh ] ; then
    . /etc/start-services/slurm_version.sh
fi

. /etc/start-services/spack_locations.sh
SLURM_LOCATION_VAR="SPACK_SLURM_${SLURM_VERSION/-/_}"

hostname=$(hostname)

if [ $hostname == 'headnode' ] ; then
    . ${SPACK_LMOD}/lmod/lmod/init/bash

    echo -e "\nstarting slurmctld..."
    ${!SLURM_LOCATION_VAR}/sbin/slurmctld -D -c -vvvv > /var/log/slurmctld.out.log 2> /var/log/slurmctld.err.log &

    echo -n -e "\nwaiting for slurmctld to start..."
    while ! nc -z localhost 6817 ; do
        sleep 1
        echo '.'
    done
    echo

    echo -e "\nmaking accounting readable to users..."
    /bin/chmod -R og+rX /var/log/slurm
fi

