FROM naturalhpc/cerulean-fake-base:latest

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
RUN mv /home/cerulean/test_files /home/webdav/files/home/cerulean/test_files && \
    rm /home/webdav/files/home/cerulean/test_files/links/link[0134] && \
    ln -s file0 /home/webdav/files/home/cerulean/test_files/links/link0 && \
    ln -s link0 /home/webdav/files/home/cerulean/test_files/links/link1 && \
    ln -s link4 /home/webdav/files/home/cerulean/test_files/links/link3 && \
    ln -s link3 /home/webdav/files/home/cerulean/test_files/links/link4 && \
    chown -R www-data:www-data /home/webdav

# Add WebDAV configuration
COPY nginx.conf /etc/nginx/sites-available/default
COPY htpasswd /etc/nginx/.htpasswd
COPY cerulean_webdav.key /etc/nginx/
COPY cerulean_webdav.crt /etc/nginx/

# Add start-up scripts
COPY start-services.sh /etc/start-services.sh
RUN chmod +x /etc/start-services.sh
CMD /etc/start-services.sh
