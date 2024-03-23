FROM naturalhpc/cerulean-fake-slurm-base:latest

USER root

RUN /bin/bash /usr/local/bin/install_slurm.sh slurm-19-05-8-1.tar.gz
COPY slurm_19_05.conf /usr/local/etc/slurm/slurm.conf
