FROM naturalhpc/cerulean-fake-base-old:latest

LABEL org.opencontainers.image.title="Cerulean fake scheduler base (older version)"
LABEL org.opencontainers.image.description="Fake server for testing Cerulean (and other software) against"
LABEL org.opencontainers.image.source="https://github.com/NaturalHPC/cerulean-test-docker-images"
LABEL org.opencontainers.image.url="https://github.com/NaturalHPC/cerulean-test-docker-images"


# Install spack
RUN apt-get update && \
    apt-get install -y python3-venv gcc g++ gfortran git build-essential xz-utils \
        bzip2 cmake unzip

RUN cd /opt && \
    git clone --depth=100 --branch=releases/v0.22 https://github.com/spack/spack.git

RUN . /opt/spack/share/spack/setup-env.sh && \
    spack config add "modules:default:enable:[tcl]" && \
    spack install lmod && \
    echo >>/etc/profile

# This makes the 'module' command available by default, but not the 'spack' command,
# because its setup script is really slow.
# To enable spack, use . /opt/spack/share/spack/setup-env.sh
RUN . /opt/spack/share/spack/setup-env.sh && \
    . $(spack location -i lmod)/lmod/lmod/init/bash && \
    echo >>/etc/profile && \
    echo "export MODULEPATH=${MODULEPATH}" >>/etc/profile && \
    echo ". $(spack location -i lmod)/lmod/lmod/init/bash" >>/etc/profile


COPY cerulean-bashrc /home/cerulean/.bashrc
RUN chown cerulean:cerulean /home/cerulean/.bashrc


# Install munge
RUN . /opt/spack/share/spack/setup-env.sh && \
    spack install munge localstatedir=/var

RUN groupadd --system munge && useradd --system --gid munge munge

RUN . /opt/spack/share/spack/setup-env.sh && \
    . $(spack location -i lmod)/lmod/lmod/init/bash && \
    \
    chown munge:munge $(spack location -i munge)/etc/munge && \
    chmod 0700 $(spack location -i munge)/etc/munge && \
    \
    mkdir -p /var/log/munge && \
    chown munge:munge /var/log/munge && \
    chmod 0700 /var/log/munge && \
    \
    mkdir -p /run/munge && \
    chown munge:munge /run/munge && \
    chmod 0755 /run/munge && \
    \
    setuser munge $(spack location -i munge)/sbin/mungekey


# Create test files
COPY endless-job.sh /usr/local/bin/endless-job.sh
RUN chmod +x /usr/local/bin/endless-job.sh


# Start munge on startup
COPY 01_01_munge.sh /etc/start-services/01_01_munge.sh

## Loading spack gets very slow for some reason if you do it many times when starting up
## a whole bunch of containers. This stuff is here to avoid having to do that on
## startup.
RUN . /opt/spack/share/spack/setup-env.sh && \
    echo "export MODULEPATH=${MODULEPATH}" >> /etc/start-services/spack_locations.sh && \
    echo "SPACK_LMOD=$(spack location -i lmod)" >> /etc/start-services/spack_locations.sh && \
    echo "SPACK_MUNGE=$(spack location -i munge)" >> /etc/start-services/spack_locations.sh
