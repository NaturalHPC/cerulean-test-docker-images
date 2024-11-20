FROM naturalhpc/cerulean-fake-scheduler-old:latest

LABEL org.opencontainers.image.title="Cerulean fake SLURM cluster base image (old version)"
LABEL org.opencontainers.image.description="Base image for older SLURM testing images"
LABEL org.opencontainers.image.source="https://github.com/NaturalHPC/cerulean-test-docker-images"
LABEL org.opencontainers.image.url="https://github.com/NaturalHPC/cerulean-test-docker-images"

USER root


# Install SLURM
RUN . /opt/spack/share/spack/setup-env.sh && \
    . $(spack location -i lmod)/lmod/lmod/init/bash && \
    spack install --deprecated slurm@17-02-6-1+pmix+cgroup sysconfdir=/etc/slurm ^pmix@2.2.3

RUN . /opt/spack/share/spack/setup-env.sh && \
    . $(spack location -i lmod)/lmod/lmod/init/bash && \
    spack install --deprecated slurm@17-11-9-2+pmix+cgroup sysconfdir=/etc/slurm ^pmix@2.2.3

RUN . /opt/spack/share/spack/setup-env.sh && \
    . $(spack location -i lmod)/lmod/lmod/init/bash && \
    spack install --deprecated slurm@18-08-9-1+pmix+cgroup sysconfdir=/etc/slurm ^pmix@2.2.3

RUN . /opt/spack/share/spack/setup-env.sh && \
    . $(spack location -i lmod)/lmod/lmod/init/bash && \
    spack install --deprecated slurm@19-05-6-1+pmix+cgroup sysconfdir=/etc/slurm ^pmix@2.2.3

RUN . /opt/spack/share/spack/setup-env.sh && \
    . $(spack location -i lmod)/lmod/lmod/init/bash && \
    spack install --deprecated slurm@20-02-4-1+pmix+cgroup sysconfdir=/etc/slurm ^pmix@2.2.3

RUN . /opt/spack/share/spack/setup-env.sh && \
    . $(spack location -i lmod)/lmod/lmod/init/bash && \
    spack clean --all


# SLURM configuration
RUN groupadd --system slurm && useradd --system --gid slurm slurm

RUN mkdir -p /etc/slurm
COPY slurm.cert /etc/slurm/slurm.cert
COPY slurm.key /etc/slurm/slurm.key
RUN chmod 600 /etc/slurm/slurm.key

COPY slurmdbd.conf /etc/slurm/slurmdbd.conf
RUN chown slurm:slurm /etc/slurm/slurmdbd.conf && \
    chmod 600 /etc/slurm/slurmdbd.conf
COPY slurm.conf /etc/slurm/slurm.conf

RUN \
    mkdir -p /var/spool/slurmctld/state && chown slurm:slurm /var/spool/slurmctld && \
    chown slurm:slurm /var/spool/slurmctld/state && \
    mkdir -p /var/log/slurm && chown slurm:slurm /var/log/slurm


# Startup scripts
COPY 02_01_hosts.sh /etc/start-services/02_01_hosts.sh
COPY 02_02_config.sh /etc/start-services/02_02_config.sh
COPY 02_03_slurmctld.sh /etc/start-services/02_03_slurmctld.sh
COPY 02_04_slurmd.sh /etc/start-services/02_04_slurmd.sh

## Loading spack gets very slow for some reason if you do it many times when starting up
## a whole bunch of containers. This stuff is here to avoid having to do that on
## startup.
RUN . /opt/spack/share/spack/setup-env.sh && \
    echo "SPACK_SLURM_17_02=$(spack location -i slurm@17-02)" >>/etc/start-services/spack_locations.sh && \
    echo "SPACK_SLURM_17_11=$(spack location -i slurm@17-11)" >>/etc/start-services/spack_locations.sh && \
    echo "SPACK_SLURM_18_08=$(spack location -i slurm@18-08)" >>/etc/start-services/spack_locations.sh && \
    echo "SPACK_SLURM_19_05=$(spack location -i slurm@19-05)" >>/etc/start-services/spack_locations.sh && \
    echo "SPACK_SLURM_20_02=$(spack location -i slurm@20-02)" >>/etc/start-services/spack_locations.sh


# Add healthcheck command
RUN apt-get update && apt-get install netcat-openbsd
HEALTHCHECK CMD /bin/nc -z localhost 22

# Clean up apt cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
