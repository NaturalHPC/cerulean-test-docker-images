#!/bin/bash

set -e      # exit on error

BASEDIR="$PWD"

cd cerulean_test_docker_images/container-base-old
docker build -t naturalhpc/cerulean-test-base-old .
cd $BASEDIR

cd cerulean_test_docker_images/container-base
docker build -t naturalhpc/cerulean-test-base .
cd $BASEDIR

cd cerulean_test_docker_images/container-webdav
docker build -t naturalhpc/cerulean-test-webdav .
cd $BASEDIR

cd cerulean_test_docker_images/container-torque
docker build -t naturalhpc/cerulean-test-torque-6 .
cd $BASEDIR

cd cerulean_test_docker_images/container-slurm
docker build -t naturalhpc/cerulean-test-slurm-base-old -f slurm-base-old.Dockerfile .
docker build -t naturalhpc/cerulean-test-slurm-base -f slurm-base.Dockerfile .
docker build -t naturalhpc/cerulean-test-slurm-16-05 -f slurm-16-05.Dockerfile .
docker build -t naturalhpc/cerulean-test-slurm-17-02 -f slurm-17-02.Dockerfile .
docker build -t naturalhpc/cerulean-test-slurm-17-11 -f slurm-17-11.Dockerfile .
docker build -t naturalhpc/cerulean-test-slurm-18-08 -f slurm-18-08.Dockerfile .
docker build -t naturalhpc/cerulean-test-slurm-19-05 -f slurm-19-05.Dockerfile .
docker build -t naturalhpc/cerulean-test-slurm-20-02 -f slurm-20-02.Dockerfile .
docker build -t naturalhpc/cerulean-test-slurm-20-11 -f slurm-20-11.Dockerfile .
cd $BASEDIR

cd cerulean_test_docker_images/container-flaky
docker build -t naturalhpc/cerulean-test-flaky .
cd $BASEDIR
