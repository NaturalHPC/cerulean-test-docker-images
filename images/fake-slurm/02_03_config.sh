#!/bin/bash

if [ -f /etc/start-services/slurm_version.sh ] ; then
    . /etc/start-services/slurm_version.sh
fi

if [[ ${SLURM_VERSION} == 20-11* ]] ; then
    cp /etc/slurm/slurm_20_11.conf /etc/slurm/slurm.conf
    rm -f /etc/slurm/cgroup.conf

elif [[ ${SLURM_VERSION} == 21-08* ]] ; then
    cp /etc/slurm/slurm_all.conf /etc/slurm/slurm.conf
    rm -f /etc/slurm/cgroup.conf

else
    cp /etc/slurm/slurm_all.conf /etc/slurm/slurm.conf
    cp /etc/slurm/cgroup_all.conf /etc/slurm/cgroup.conf
fi

echo "module load slurm/${SLURM_VERSION}" >>/etc/profile

