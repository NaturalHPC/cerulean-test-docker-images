FROM mdstudio/cerulean-test-slurm-base:latest

USER root

RUN /bin/bash /usr/local/bin/install_slurm.sh slurm-20-11-4-1.tar.gz
