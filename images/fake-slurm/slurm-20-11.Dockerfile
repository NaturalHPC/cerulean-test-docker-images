FROM naturalhpc/cerulean-fake-slurm-base:latest

LABEL org.opencontainers.image.title="Cerulean fake SLURM 20.11 cluster"
LABEL org.opencontainers.image.description="Fake cluster for testing Cerulean (and other software) against"
LABEL org.opencontainers.image.source="https://github.com/NaturalHPC/cerulean-test-docker-images"
LABEL org.opencontainers.image.url="https://github.com/NaturalHPC/cerulean-test-docker-images"

USER root

RUN /bin/bash /usr/local/bin/install_slurm.sh slurm-20-11-4-1.tar.gz
COPY slurm_20_11.conf /usr/local/etc/slurm/slurm.conf
