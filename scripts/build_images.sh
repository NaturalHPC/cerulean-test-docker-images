#!/bin/bash

set -e      # exit on error

BASEDIR="$PWD"

cd images/fake-base-old
echo '*************************************'
echo '          fake-base-old'
echo '*************************************'
docker buildx build -t naturalhpc/cerulean-fake-base-old .
cd $BASEDIR

cd images/fake-base
echo '*************************************'
echo '             fake-base'
echo '*************************************'
docker buildx build -t naturalhpc/cerulean-fake-base .
cd $BASEDIR

cd images/fake-fileserver
echo '*************************************'
echo '           fake-fileserver'
echo '*************************************'
docker buildx build -t naturalhpc/cerulean-fake-fileserver .
cd $BASEDIR

cd images/fake-webdav
echo '*************************************'
echo '            fake-webdav'
echo '*************************************'
docker buildx build -t naturalhpc/cerulean-fake-webdav .
cd $BASEDIR

cd images/fake-scheduler-old
echo '*************************************'
echo '         fake-scheduler-old'
echo '*************************************'
docker buildx build -t naturalhpc/cerulean-fake-scheduler-old .
cd $BASEDIR

cd images/fake-torque
echo '*************************************'
echo '           fake-torque-6'
echo '*************************************'
docker buildx build -t naturalhpc/cerulean-fake-torque-6 .
cd $BASEDIR

cd images/fake-slurm-old
echo '*************************************'
echo '         fake-slurm-base-old'
echo '*************************************'
docker buildx build -t naturalhpc/cerulean-fake-slurm-base-old -f slurm-base-old.Dockerfile .
echo '*************************************'
echo '           fake-slurm-17-02'
echo '*************************************'
docker buildx build -t naturalhpc/cerulean-fake-slurm-17-02 -f slurm-17-02.Dockerfile .
echo '*************************************'
echo '           fake-slurm-17-11'
echo '*************************************'
docker buildx build -t naturalhpc/cerulean-fake-slurm-17-11 -f slurm-17-11.Dockerfile .
echo '*************************************'
echo '           fake-slurm-18-08'
echo '*************************************'
docker buildx build -t naturalhpc/cerulean-fake-slurm-18-08 -f slurm-18-08.Dockerfile .
echo '*************************************'
echo '           fake-slurm-19-05'
echo '*************************************'
docker buildx build -t naturalhpc/cerulean-fake-slurm-19-05 -f slurm-19-05.Dockerfile .
echo '*************************************'
echo '           fake-slurm-20-02'
echo '*************************************'
docker buildx build -t naturalhpc/cerulean-fake-slurm-20-02 -f slurm-20-02.Dockerfile .
cd $BASEDIR

cd images/fake-scheduler
echo '*************************************'
echo '           fake-scheduler'
echo '*************************************'
docker buildx build -t naturalhpc/cerulean-fake-scheduler .
cd $BASEDIR

cd images/fake-slurm
echo '*************************************'
echo '           fake-slurm-base'
echo '*************************************'
docker buildx build -t naturalhpc/cerulean-fake-slurm-base -f slurm-base.Dockerfile .
echo '*************************************'
echo '           fake-slurm-20-11'
echo '*************************************'
docker buildx build -t naturalhpc/cerulean-fake-slurm-20-11 -f slurm-20-11.Dockerfile .
echo '*************************************'
echo '           fake-slurm-21-08'
echo '*************************************'
docker buildx build -t naturalhpc/cerulean-fake-slurm-21-08 -f slurm-21-08.Dockerfile .
echo '*************************************'
echo '           fake-slurm-22-05'
echo '*************************************'
docker buildx build -t naturalhpc/cerulean-fake-slurm-22-05 -f slurm-22-05.Dockerfile .
echo '*************************************'
echo '           fake-slurm-23-02'
echo '*************************************'
docker buildx build -t naturalhpc/cerulean-fake-slurm-23-02 -f slurm-23-02.Dockerfile .
echo '*************************************'
echo '           fake-slurm-23-11'
echo '*************************************'
docker buildx build -t naturalhpc/cerulean-fake-slurm-23-11 -f slurm-23-11.Dockerfile .
cd $BASEDIR

cd images/fake-slurm-flaky
echo '*************************************'
echo '           fake-slurm-flaky'
echo '*************************************'
docker buildx build -t naturalhpc/cerulean-fake-slurm-flaky .
cd $BASEDIR
