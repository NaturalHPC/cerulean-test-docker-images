FROM phusion/baseimage:18.04-1.0.0
# build as cerulean-fake-base-old

LABEL org.opencontainers.image.title="Cerulean fake base image (older version)"
LABEL org.opencontainers.image.description="Base image for older testing images"
LABEL org.opencontainers.image.source="https://github.com/NaturalHPC/cerulean-test-docker-images"
LABEL org.opencontainers.image.url="https://github.com/NaturalHPC/cerulean-test-docker-images"

USER root

# Add cerulean user
RUN groupadd --system cerulean && useradd --system --gid cerulean --create-home cerulean --shell /bin/bash
RUN echo cerulean:kingfisher | chpasswd

WORKDIR /home/cerulean
COPY .ssh .ssh
RUN chmod 700 .ssh && \
chmod 600 .ssh/id1_rsa .ssh/id2_rsa && \
chmod 644 .ssh/authorized_keys .ssh/id1_rsa.pub .ssh/id2_rsa.pub && \
chown -R cerulean:cerulean .ssh

# Install SSH server
RUN apt-get update && \
    apt-get install -y --no-install-recommends openssh-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
COPY ssh_host_dsa_key /etc/ssh/ssh_host_dsa_key
COPY ssh_host_dsa_key.pub /etc/ssh/ssh_host_dsa_key.pub
COPY ssh_host_ecdsa_key /etc/ssh/ssh_host_ecdsa_key
COPY ssh_host_ecdsa_key.pub /etc/ssh/ssh_host_ecdsa_key.pub
COPY ssh_host_ed25519_key /etc/ssh/ssh_host_ed25519_key
COPY ssh_host_ed25519_key.pub /etc/ssh/ssh_host_ed25519_key.pub
COPY ssh_host_rsa_key /etc/ssh/ssh_host_rsa_key
COPY ssh_host_rsa_key.pub /etc/ssh/ssh_host_rsa_key.pub
RUN chmod 600 /etc/ssh/*_key
EXPOSE 22

# Load basic settings when running ssh -c
RUN echo >>/home/cerulean/.bashrc && \
    echo '. /etc/profile' >>/home/cerulean/.bashrc

# Add start-up scripts
COPY start-services.sh /etc/start-services.sh
COPY start-services /etc/start-services
CMD /etc/start-services.sh
