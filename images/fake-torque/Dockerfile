FROM naturalhpc/cerulean-fake-scheduler-old:latest

LABEL org.opencontainers.image.title="Cerulean fake Torque 6.1.3 cluster"
LABEL org.opencontainers.image.description="Fake cluster for testing Cerulean (and other software) against"
LABEL org.opencontainers.image.source="https://github.com/NaturalHPC/cerulean-test-docker-images"
LABEL org.opencontainers.image.url="https://github.com/NaturalHPC/cerulean-test-docker-images"

USER root

RUN apt-get update && \
    apt-get --no-install-recommends -y install tar gcc g++ make \
        pkg-config libssl-dev libxml2-dev libboost-dev wget git \
        libtool m4 automake && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /build
WORKDIR /build
COPY torque_compile_on_newer_gcc.patch /build
RUN git clone https://github.com/adaptivecomputing/torque.git && \
    cd torque && git checkout 6.1.3 && \
    patch -p1 <../torque_compile_on_newer_gcc.patch

WORKDIR /build/torque

# Run command with output muted, if it fails, show output and exit
RUN (./autogen.sh >/tmp/autogen.log 2>&1 || (tail -n 50 /tmp/autogen.log && exit 1)) && \
    (./configure --disable-gcc-warnings >/tmp/configure.log 2>&1 || (tail -n 50 /tmp/configure.log && exit 1)) && \
    (make >/tmp/make.log 2>&1 || (cat /tmp/configure.log && tail -n 50 /tmp/make.log && exit 1)) && \
    (make install >/tmp/make_install.log 2>&1 || (tail -n 50 /tmp/make_install.log && exit 1))

RUN \
    ln -s /var/spool/torque/mom_logs /var/log/mom_logs && \
    ln -s /var/spool/torque/server_logs /var/log/server_logs && \
    ln -s /var/spool/torque/sched_logs /var/log/sched_logs && \
    ln -s /var/spool/torque/job_logs /var/log/job_logs

COPY 02_01_torque.sh /etc/start-services/02_01_torque.sh

HEALTHCHECK --interval=5s CMD pbsnodes -l free
