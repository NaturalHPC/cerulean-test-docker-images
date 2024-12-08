FROM naturalhpc/cerulean-fake-scheduler:latest

LABEL org.opencontainers.image.title="Cerulean fake SLURM cluster base image"
LABEL org.opencontainers.image.description="Base image for SLURM testing images"
LABEL org.opencontainers.image.source="https://github.com/NaturalHPC/cerulean-test-docker-images"
LABEL org.opencontainers.image.url="https://github.com/NaturalHPC/cerulean-test-docker-images"

USER root

# Install MariaDB for storing accounting information
RUN . /opt/spack/share/spack/setup-env.sh && \
    . $(spack location -i lmod)/lmod/lmod/init/bash && \
    spack install mariadb


# Update Spack definitions for SLURM
COPY slurm-package.py /opt/spack/var/spack/repos/builtin/packages/slurm/package.py


# Install SLURM
RUN . /opt/spack/share/spack/setup-env.sh && \
    . $(spack location -i lmod)/lmod/lmod/init/bash && \
    spack install --deprecated slurm@20-11-9-1+mariadb+pmix+cgroup sysconfdir=/etc/slurm ^pmix@2.2.3

RUN . /opt/spack/share/spack/setup-env.sh && \
    . $(spack location -i lmod)/lmod/lmod/init/bash && \
    spack install --deprecated slurm@21-08-8-2+mariadb+pmix+cgroup sysconfdir=/etc/slurm ^pmix@3.2.3

RUN . /opt/spack/share/spack/setup-env.sh && \
    . $(spack location -i lmod)/lmod/lmod/init/bash && \
    spack install --deprecated slurm@22-05-9-1+mariadb+pmix+cgroup sysconfdir=/etc/slurm ^pmix@3.2.3

RUN . /opt/spack/share/spack/setup-env.sh && \
    . $(spack location -i lmod)/lmod/lmod/init/bash && \
    spack install --deprecated slurm@23-02-8-1+mariadb+pmix+cgroup sysconfdir=/etc/slurm ^pmix@3.2.3

# Spack will only compile OpenMPI 5.x with pmix 4.2.4, and it needs hwloc 2, so we'll
# use those so that derived images can install it properly.
RUN . /opt/spack/share/spack/setup-env.sh && \
    . $(spack location -i lmod)/lmod/lmod/init/bash && \
    spack install slurm@23-11-10-1+mariadb+pmix+cgroup sysconfdir=/etc/slurm ^pmix@4.2.4 ^hwloc@2

RUN . /opt/spack/share/spack/setup-env.sh && \
    . $(spack location -i lmod)/lmod/lmod/init/bash && \
    spack install slurm@24-05-4-1+mariadb+pmix+cgroup sysconfdir=/etc/slurm ^pmix@4.2.4 ^hwloc@2

RUN . /opt/spack/share/spack/setup-env.sh && \
    . $(spack location -i lmod)/lmod/lmod/init/bash && \
    spack install slurm@24-11-0-1+mariadb+pmix+cgroup sysconfdir=/etc/slurm ^pmix@4.2.4 ^hwloc@2

RUN . /opt/spack/share/spack/setup-env.sh && \
    . $(spack location -i lmod)/lmod/lmod/init/bash && \
    spack clean --all


# Set up MariaDB for storing accounting information
RUN groupadd --system mysql && useradd --system --gid mysql mysql
RUN mkdir -p /var/mysql && chown mysql:mysql /var/mysql

COPY my.cnf /etc/my.cnf

RUN . /opt/spack/share/spack/setup-env.sh && \
    . $(spack location -i lmod)/lmod/lmod/init/bash && \
    module load mariadb && \
    setuser mysql $(spack location -i mariadb)/scripts/mariadb-install-db

RUN bash -l -c ' \
    module load mariadb && setuser mysql mariadbd-safe &' && \
    bash -l -c " \
    while [ ! -e /tmp/mysql.sock ] ; do sleep 0.1 ; done" && \
    bash -l -c " \
    module load mariadb && \
    mariadb -u root -h localhost -e \"create user slurm@localhost identified by 'password';\" && \
    mariadb -u root -h localhost -e \"grant all on slurm_acct_db.* to slurm@localhost;\" && \
    mariadb -u root -h localhost -e \"create database slurm_acct_db;\"" && \
    ls -l /var/mysql


# Set up slurm
RUN groupadd --system slurm && useradd --system --gid slurm slurm

RUN mkdir -p /etc/slurm
COPY slurm.cert /etc/slurm/slurm.cert
COPY slurm.key /etc/slurm/slurm.key
RUN chmod 600 /etc/slurm/slurm.key

COPY slurmdbd.conf /etc/slurm/slurmdbd.conf
RUN chown slurm:slurm /etc/slurm/slurmdbd.conf && \
    chmod 600 /etc/slurm/slurmdbd.conf
COPY slurm.conf /etc/slurm/slurm_all.conf
COPY slurm_20_11.conf /etc/slurm/slurm_20_11.conf
COPY cgroup.conf /etc/slurm/cgroup_all.conf

RUN \
    mkdir -p /var/spool/slurmctld && chown slurm:slurm /var/spool/slurmctld && \
    mkdir -p /var/log/slurm && chown slurm:slurm /var/log/slurm


# Add start-up scripts
COPY 02_01_mariadb.sh /etc/start-services/02_01_mariadb.sh
COPY 02_02_hosts.sh /etc/start-services/02_02_hosts.sh
COPY 02_03_config.sh /etc/start-services/02_03_config.sh
COPY 02_04_slurmdbd.sh /etc/start-services/02_04_slurmdbd.sh
COPY 02_05_slurmctld.sh /etc/start-services/02_05_slurmctld.sh
COPY 02_06_slurmd.sh /etc/start-services/02_06_slurmd.sh

## Loading spack gets very slow for some reason if you do it many times when starting up
## a whole bunch of containers. This stuff is here to avoid having to do that on
## startup.
RUN . /opt/spack/share/spack/setup-env.sh && \
    echo "SPACK_SLURM_20_11=$(spack location -i slurm@20-11)" >>/etc/start-services/spack_locations.sh && \
    echo "SPACK_SLURM_21_08=$(spack location -i slurm@21-08)" >>/etc/start-services/spack_locations.sh && \
    echo "SPACK_SLURM_22_05=$(spack location -i slurm@22-05)" >>/etc/start-services/spack_locations.sh && \
    echo "SPACK_SLURM_23_02=$(spack location -i slurm@23-02)" >>/etc/start-services/spack_locations.sh && \
    echo "SPACK_SLURM_23_11=$(spack location -i slurm@23-11)" >>/etc/start-services/spack_locations.sh && \
    echo "SPACK_SLURM_24_05=$(spack location -i slurm@24-05)" >>/etc/start-services/spack_locations.sh && \
    echo "SPACK_SLURM_24_11=$(spack location -i slurm@24-11)" >>/etc/start-services/spack_locations.sh


# Add healthcheck command
RUN apt-get update && apt-get install netcat-openbsd
HEALTHCHECK CMD /bin/nc -z localhost 22

# Clean up apt cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

