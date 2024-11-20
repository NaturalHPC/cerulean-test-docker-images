FROM naturalhpc/cerulean-fake-slurm-17-11:latest

LABEL org.opencontainers.image.title="Cerulean fake flaky SLURM cluster"
LABEL org.opencontainers.image.description="Fake cluster for testing Cerulean (and other software) against"
LABEL org.opencontainers.image.source="https://github.com/NaturalHPC/cerulean-test-docker-images"
LABEL org.opencontainers.image.url="https://github.com/NaturalHPC/cerulean-test-docker-images"

USER root

# Add start-up scripts
COPY 03_01_flaky.sh /etc/start-services/03_01_flaky.sh

