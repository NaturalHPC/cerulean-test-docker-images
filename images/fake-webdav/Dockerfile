FROM naturalhpc/cerulean-fake-fileserver:latest

LABEL org.opencontainers.image.title="Cerulean fake WebDAV server"
LABEL org.opencontainers.image.description="Fake server for testing Cerulean (and other software) against"
LABEL org.opencontainers.image.source="https://github.com/NaturalHPC/cerulean-test-docker-images"
LABEL org.opencontainers.image.url="https://github.com/NaturalHPC/cerulean-test-docker-images"

USER root

# Install nginx and create directories
RUN apt-get update && \
    apt-get install -y --no-install-recommends nginx-full && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /home/webdav/files/home/cerulean && \
    mkdir -p /home/webdav/client_temp && \
    mkdir -p /home/webdav/protected_files && \
    chown -R www-data:www-data /home/webdav && \
    chmod 775 /home/webdav /home/webdav/files

# Patch up test files
# The working symlinks need to be remade to point to the right file.
# nginx doesn't like broken symlinks, and WebDAV doesn't support symlinks,
# so we remove them to avoid 500 Internal Server Errors.
RUN mv /home/cerulean/test_files /home/webdav/files/home/cerulean/test_files && \
    rm /home/webdav/files/home/cerulean/test_files/links/link[01234] && \
    ln -s file0 /home/webdav/files/home/cerulean/test_files/links/link0 && \
    ln -s link0 /home/webdav/files/home/cerulean/test_files/links/link1 && \
    chown -R www-data:www-data /home/webdav

# Add WebDAV configuration
COPY nginx.conf /etc/nginx/sites-available/default
COPY htpasswd /etc/nginx/.htpasswd
COPY cerulean_webdav.key /etc/nginx/
COPY cerulean_webdav.crt /etc/nginx/

# Add start-up scripts
COPY 02_01_nginx.sh /etc/start-services/02_01_nginx.sh
