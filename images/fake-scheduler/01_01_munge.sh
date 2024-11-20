#!/bin/bash

. /etc/start-services/spack_locations.sh

${SPACK_LMOD}/lmod/lmod/init/bash

echo -e "\nstarting munged..."

module load munge

setuser munge ${SPACK_MUNGE}/sbin/munged &

echo -n -e "\nwaiting for munged to start..."
while [ ! -e /run/munge/munge.socket.2 ] ; do
    sleep 1
    echo '.'
done
echo

