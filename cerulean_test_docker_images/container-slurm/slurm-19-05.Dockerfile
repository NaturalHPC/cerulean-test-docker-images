FROM mdstudio/cerulean-test-slurm-base:latest

USER root

RUN /bin/bash /usr/local/bin/install_slurm.sh slurm-19-05-8-1.tar.gz
