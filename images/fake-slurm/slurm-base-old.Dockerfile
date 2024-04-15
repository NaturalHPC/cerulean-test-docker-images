FROM naturalhpc/cerulean-fake-base-old:latest

LABEL org.opencontainers.image.title="Cerulean fake SLURM cluster base image"
LABEL org.opencontainers.image.description="Base image for older SLURM testing images"
LABEL org.opencontainers.image.source="https://github.com/NaturalHPC/cerulean-test-docker-images"
LABEL org.opencontainers.image.url="https://github.com/NaturalHPC/cerulean-test-docker-images"

USER root

# Install munge (needed by slurm)
RUN apt-get update && \
    apt-get install -y --no-install-recommends munge libmunge2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN chmod 0700 /etc/munge /var/log/munge && \
chmod 0711 /var/lib/munge && \
mkdir /var/run/munge && \
chmod 0755 /var/run/munge && \
chmod 0400 /etc/munge/munge.key

RUN chown -R munge:munge /etc/munge /var/lib/munge /var/log/munge /var/run/munge


# Install slurm
RUN groupadd --system slurm && useradd --system --gid slurm --create-home slurm
RUN echo slurm:slurm | chpasswd

RUN mkdir -p /var/spool/slurmctld/state
RUN chown -R slurm:slurm /var/spool/slurmctld

RUN mkdir -p /usr/local/etc/slurm

RUN mkdir -p /var/log/slurm
RUN chown -R slurm:slurm /var/log/slurm

COPY slurm.cert /usr/local/etc/slurm/slurm.cert
COPY slurm.key /usr/local/etc/slurm/slurm.key
RUN chmod 600 /usr/local/etc/slurm/slurm.key

COPY install_slurm_old.sh /usr/local/bin/install_slurm.sh
COPY slurm_timeout.diff /usr/local/etc/
WORKDIR /usr/local
RUN apt-get update && \
    apt-get --no-install-recommends install -y gcc make libc6-dev libssl-dev \
        libmunge-dev tar wget patch python

COPY slurm_old.conf /usr/local/etc/slurm/slurm.conf

# Add start-up scripts
COPY start-services-old.sh /etc/start-services.sh
RUN chmod +x /etc/start-services.sh
CMD /etc/start-services.sh

# Add healthcheck command
RUN apt-get update && apt-get install netcat-openbsd
HEALTHCHECK CMD /bin/nc -z localhost 22

# Clean up apt cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

