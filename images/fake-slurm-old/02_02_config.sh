#!/bin/bash

if [ -f /etc/start-services/slurm_version.sh ] ; then
    . /etc/start-services/slurm_version.sh
fi

echo "module load slurm/${SLURM_VERSION}" >>/etc/profile

