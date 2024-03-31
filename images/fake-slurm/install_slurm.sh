#!/bin/bash
#
# This script installs the necessary tools and libraries to compile slurm, then
# downloads a slurm version, compiles and installs it, and removes any unnecessary
# code and tools afterwards.

# exit on error
set -e

cd /usr/local

apt-get update
apt-get --no-install-recommends install -y gcc make libssl-dev libmunge-dev munge tar wget patch python3 python-is-python3

NAME=$(basename -s .tar.gz $1)

wget -nv https://github.com/SchedMD/slurm/archive/$1
tar -xzf $1

cd /usr/local/slurm-$NAME
patch -p0 </usr/local/etc/slurm_timeout.diff

echo 'Configuring...'
./configure --prefix=/usr/local --sysconfdir=/usr/local/etc/slurm >/tmp/configure.log 2>&1 || (cat /tmp/configure.log && exit 1)
tail -n 20 /tmp/configure.log
echo 'Building...'
make >/tmp/make.log 2>&1 || (cat /tmp/make.log && exit 1)
tail -n 20 /tmp/make.log
echo 'Installing...'
make install >/tmp/make_install.log 2>&1 || (cat /tmp/make_install.log && exit 1)
tail -n 20 /tmp/make_install.log

echo 'Cleaning up...'
cd /usr/local
rm -rf /usr/local/slurm-$NAME
rm /usr/local/$1

# NOTE: removing tar seems to break stuff, and munge needs Python3 to run
apt-get purge -y gcc make wget libssl-dev libmunge-dev
apt-get autoremove -y
apt-get clean -y
echo 'Done.'
