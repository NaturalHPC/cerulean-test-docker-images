FROM naturalhpc/cerulean-fake-slurm-base-old:latest

USER root

RUN /bin/bash /usr/local/bin/install_slurm.sh slurm-17-02-11-1.tar.gz
