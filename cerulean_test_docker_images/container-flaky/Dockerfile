FROM naturalhpc/cerulean-test-slurm-17-11:latest

USER root

# Add start-up scripts
COPY start-services.sh /etc/start-services.sh
RUN chmod +x /etc/start-services.sh
CMD /etc/start-services.sh
