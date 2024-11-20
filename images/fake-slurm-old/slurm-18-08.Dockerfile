FROM naturalhpc/cerulean-fake-slurm-base-old:latest

LABEL org.opencontainers.image.title="Cerulean fake SLURM 18.08 cluster"
LABEL org.opencontainers.image.description="Fake cluster for testing Cerulean (and other software) against"
LABEL org.opencontainers.image.source="https://github.com/NaturalHPC/cerulean-test-docker-images"
LABEL org.opencontainers.image.url="https://github.com/NaturalHPC/cerulean-test-docker-images"

USER root

RUN echo "SLURM_VERSION=18-08" >/etc/start-services/slurm_version.sh

