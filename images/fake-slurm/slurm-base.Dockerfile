FROM naturalhpc/cerulean-fake-base:latest

LABEL org.opencontainers.image.title="Cerulean fake SLURM cluster base image"
LABEL org.opencontainers.image.description="Base image for SLURM testing images"
LABEL org.opencontainers.image.source="https://github.com/NaturalHPC/cerulean-test-docker-images"
LABEL org.opencontainers.image.url="https://github.com/NaturalHPC/cerulean-test-docker-images"

USER root

# Install munge (needed by slurm)
RUN apt-get update && apt-get install -y --no-install-recommends munge libmunge2
RUN chmod 0700 /etc/munge /var/log/munge && \
chmod 0711 /var/lib/munge && \
mkdir /var/run/munge && \
chmod 0755 /var/run/munge && \
chmod 0400 /etc/munge/munge.key && \
chown -R munge:munge /etc/munge /var/lib/munge /var/log/munge /var/run/munge


# Install and set up MariaDB for storing accounting information
RUN apt-get update && \
    apt-get install -y --no-install-recommends mariadb-server mariadb-client libmariadb3
RUN mkdir /run/mysqld && chown mysql:mysql /run/mysqld
RUN setuser mysql /usr/bin/mariadbd-safe & \
    sleep 1 && \
    mariadb -u root -h localhost -e "create user slurm@localhost identified by 'password';" && \
    mariadb -u root -h localhost -e "grant all on slurm_acct_db.* to slurm@localhost;" && \
    mariadb -u root -h localhost -e "create database slurm_acct_db;"


# Prepare everything to install slurm
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

COPY install_slurm.sh /usr/local/bin/
COPY slurm_timeout.diff /usr/local/etc/
WORKDIR /usr/local
RUN apt-get update && \
    apt-get --no-install-recommends install -y gcc make libc6-dev libssl-dev \
        libmunge-dev tar wget patch python3

COPY slurmdbd.conf /usr/local/etc/slurm/slurmdbd.conf
RUN chown slurm:slurm /usr/local/etc/slurm/slurmdbd.conf && \
    chmod 600 /usr/local/etc/slurm/slurmdbd.conf
COPY slurm.conf /usr/local/etc/slurm/slurm.conf
COPY cgroup.conf /usr/local/etc/slurm/cgroup.conf

# Add start-up scripts
COPY start-services.sh /etc/start-services.sh
RUN chmod +x /etc/start-services.sh
CMD /etc/start-services.sh

# Clean up apt cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

