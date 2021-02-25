FROM mdstudio/cerulean-test-base:latest

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

COPY start-services.sh /etc/start-services.sh
RUN chmod +x /etc/start-services.sh
CMD /etc/start-services.sh

HEALTHCHECK --interval=1s CMD ssh -o NoHostAuthenticationForLocalhost=yes -i /home/cerulean/.ssh/id1_rsa cerulean@localhost /bin/true && pbsnodes -l free $(hostname) || exit 1
