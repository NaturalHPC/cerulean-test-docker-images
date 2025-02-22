#!/bin/bash

if [ -f /etc/start-services/slurm_version.sh ] ; then
    . /etc/start-services/slurm_version.sh
fi

. /etc/start-services/spack_locations.sh
SLURM_LOCATION_VAR="SPACK_SLURM_${SLURM_VERSION/-/_}"

hostname=$(hostname)

${SPACK_LMOD}/lmod/lmod/init/bash

if [ $hostname == 'headnode' ] ; then
    if [ -n "$SELF_CONTAINED" ] ; then
        echo -e "\nstarting compute nodes..."
        ${!SLURM_LOCATION_VAR}/sbin/slurmd -D -N node-0 > /var/log/slurmd-node-0.out.log 2> /var/log/slurmd-node-0.err.log &
        ${!SLURM_LOCATION_VAR}/sbin/slurmd -D -N node-1 > /var/log/slurmd-node-1.out.log 2> /var/log/slurmd-node-1.err.log &
        ${!SLURM_LOCATION_VAR}/sbin/slurmd -D -N node-2 > /var/log/slurmd-node-2.out.log 2> /var/log/slurmd-node-2.err.log &
        ${!SLURM_LOCATION_VAR}/sbin/slurmd -D -N node-3 > /var/log/slurmd-node-3.out.log 2> /var/log/slurmd-node-3.err.log &
        ${!SLURM_LOCATION_VAR}/sbin/slurmd -D -N node-4 > /var/log/slurmd-node-4.out.log 2> /var/log/slurmd-node-4.err.log &
    fi

else
    # start a single node based on hostname
    nodename="$(basename ${hostname} '.example.org')"
    echo -e "\nstarting compute node ${nodename}..."
    ${!SLURM_LOCATION_VAR}/sbin/slurmd -D -N ${nodename} > /var/log/slurmd-${nodename}.out.log 2> /var/log/slurmd-${nodename}.err.log &

fi

