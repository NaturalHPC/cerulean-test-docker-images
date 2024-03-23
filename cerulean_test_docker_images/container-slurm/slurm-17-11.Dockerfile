FROM naturalhpc/cerulean-test-slurm-base-old:latest

USER root

RUN /bin/bash /usr/local/bin/install_slurm.sh slurm-17-11-13-2.tar.gz
