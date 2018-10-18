#!/bin/bash

BASEDIR="$PWD"

cd cerulean_test_docker_images/container-base
docker build -t cerulean-test-base .
cd $BASEDIR

cd cerulean_test_docker_images/container-torque
docker build -t cerulean-test-torque-6 .
cd $BASEDIR

cd cerulean_test_docker_images/container-slurm
docker build -t cerulean-test-slurm-14-11 -f slurm-14-11.Dockerfile .
docker build -t cerulean-test-slurm-15-08 -f slurm-15-08.Dockerfile .
docker build -t cerulean-test-slurm-16-05 -f slurm-16-05.Dockerfile .
docker build -t cerulean-test-slurm-17-02 -f slurm-17-02.Dockerfile .
docker build -t cerulean-test-slurm-17-11 -f slurm-17-11.Dockerfile .
cd $BASEDIR
