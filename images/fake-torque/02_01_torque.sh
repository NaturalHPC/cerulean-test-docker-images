#!/bin/bash
#set -e

# Set the ulimits for this container. Must be run with the --cap-add SYS_RESOURCE option
ulimit -l unlimited
ulimit -s unlimited

# Configure torque with current hostname
echo 'headnode' > /var/spool/torque/server_name
echo '$pbsserver headnode' > /var/spool/torque/mom_priv/config

# Setup Torque
. /etc/profile.d/torque.sh
trqauthd start
yes | /bin/bash /build/torque/torque.setup root localhost
qmgr -c 'create queue debug queue_type=execution'
qmgr -c 'set queue debug enabled=true'
qmgr -c 'set queue debug started=true'
qmgr -c 'set server scheduling=true'
qmgr -c 'set server default_queue=debug'
qterm

# Add (virtual) nodes
echo "node np=2" >>/var/spool/torque/server_priv/nodes
echo "node-1 np=2 mom_service_port=30001 mom_manager_port=30002" >>/var/spool/torque/server_priv/nodes
echo "node-2 np=2 mom_service_port=31001 mom_manager_port=31002" >>/var/spool/torque/server_priv/nodes
echo "node-3 np=2 mom_service_port=32001 mom_manager_port=32002" >>/var/spool/torque/server_priv/nodes
echo "node-4 np=2 mom_service_port=33001 mom_manager_port=33002" >>/var/spool/torque/server_priv/nodes

my_ip=$(grep headnode /etc/hosts | cut -f 1)
echo "$my_ip node node-1 node-2 node-3 node-4" >>/etc/hosts

# Start Torque
echo -e "\nstarting Torque..."
pbs_server
pbs_sched
sleep 2
pbs_mom -H node >/var/log/mom-0.out.log 2>/var/log/mom-0.err.log
pbs_mom -m -M 30001 -R 30002 -H node-1
pbs_mom -m -M 31001 -R 31002 -H node-2
pbs_mom -m -M 32001 -R 32002 -H node-3
pbs_mom -m -M 33001 -R 33002 -H node-4

