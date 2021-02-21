#!/bin/bash

set -e      # exit on error

BASEDIR="$PWD"

cd cerulean_test_docker_images/container-base
docker build -t mdstudio/cerulean-test-base .
cd $BASEDIR

cd cerulean_test_docker_images/container-webdav
docker build -t mdstudio/cerulean-test-webdav .
cd $BASEDIR

cd cerulean_test_docker_images/container-torque
docker build -t mdstudio/cerulean-test-torque-6 .
cd $BASEDIR

cd cerulean_test_docker_images/container-slurm
docker build -t mdstudio/cerulean-test-slurm-base -f slurm-base.Dockerfile .
docker build -t mdstudio/cerulean-test-slurm-16-05 -f slurm-16-05.Dockerfile .
docker build -t mdstudio/cerulean-test-slurm-17-02 -f slurm-17-02.Dockerfile .
docker build -t mdstudio/cerulean-test-slurm-17-11 -f slurm-17-11.Dockerfile .
docker build -t mdstudio/cerulean-test-slurm-18-08 -f slurm-18-08.Dockerfile .
cd $BASEDIR

cd cerulean_test_docker_images/container-flaky
docker build -t mdstudio/cerulean-test-flaky .
cd $BASEDIR
