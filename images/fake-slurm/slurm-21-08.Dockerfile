FROM naturalhpc/cerulean-fake-slurm-base:latest

LABEL org.opencontainers.image.title="Cerulean fake SLURM 21.08 cluster"
LABEL org.opencontainers.image.description="Fake cluster for testing Cerulean (and other software) against"
LABEL org.opencontainers.image.source="https://github.com/NaturalHPC/cerulean-test-docker-images"
LABEL org.opencontainers.image.url="https://github.com/NaturalHPC/cerulean-test-docker-images"

USER root

# Remove this, 21.08 is too old to support the options we're using and its defaults work
RUN rm -f /usr/local/etc/slurm/cgroup.conf

RUN /bin/bash /usr/local/bin/install_slurm.sh slurm-21-08-8-2.tar.gz
