FROM naturalhpc/cerulean-fake-base:latest

LABEL org.opencontainers.image.title="Cerulean fake file server"
LABEL org.opencontainers.image.description="Fake server for testing Cerulean (and other software) against"
LABEL org.opencontainers.image.source="https://github.com/NaturalHPC/cerulean-test-docker-images"
LABEL org.opencontainers.image.url="https://github.com/NaturalHPC/cerulean-test-docker-images"


# Create test files
COPY create-test-files.sh /home/cerulean/create-test-files.sh
RUN chmod +x /home/cerulean/create-test-files.sh && \
    /home/cerulean/create-test-files.sh && \
    chown -R cerulean:cerulean /home/cerulean/test_files
RUN rm /home/cerulean/create-test-files.sh

# Enable server side debug output
RUN echo "LogLevel DEBUG3" >>/etc/ssh/sshd_config
RUN sed -i -e 's^Subsystem[[:space:]]*sftp[[:space:]]*/usr/lib/openssh/sftp-server^Subsystem sftp /usr/lib/openssh/sftp-server -l DEBUG3^' /etc/ssh/sshd_config

