FROM naturalhpc/cerulean-test-slurm-base:latest

USER root

RUN /bin/bash /usr/local/bin/install_slurm.sh slurm-20-11-4-1.tar.gz
COPY slurm_20_11.conf /usr/local/etc/slurm/slurm.conf
