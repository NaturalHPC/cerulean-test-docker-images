FROM naturalhpc/cerulean-fake-slurm-base-old:latest

USER root

RUN /bin/bash /usr/local/bin/install_slurm.sh slurm-18-08-9-1.tar.gz
