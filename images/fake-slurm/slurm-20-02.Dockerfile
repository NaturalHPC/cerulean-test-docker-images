FROM naturalhpc/cerulean-fake-slurm-base:latest

USER root

RUN /bin/bash /usr/local/bin/install_slurm.sh slurm-20-02-6-1.tar.gz
COPY slurm_19_05.conf /usr/local/etc/slurm/slurm.conf
