FROM naturalhpc/cerulean-fake-slurm-base:latest

LABEL org.opencontainers.image.title="Cerulean fake SLURM 23.11 cluster"
LABEL org.opencontainers.image.description="Fake cluster for testing Cerulean (and other software) against"
LABEL org.opencontainers.image.source="https://github.com/NaturalHPC/cerulean-test-docker-images"
LABEL org.opencontainers.image.url="https://github.com/NaturalHPC/cerulean-test-docker-images"

USER root

RUN /bin/bash /usr/local/bin/install_slurm.sh slurm-23-11-5-1.tar.gz
