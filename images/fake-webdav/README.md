# WebDAV test container

This container contains an HTTP server with WebDAV support.

The HTTPS server has a self-signed certificate that was generated using

```
openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes -keyout cerulean_webdav.key -out cerulean_webdav.crt -extensions san -config <(echo "[req]"; echo distinguished_name=req; echo "[san]"; echo subjectAltName=DNS:cerulean-test-webdav,IP:127.0.0.1) -subj /CN=localhost
```

The `cerulean_webdav.crt` file is the certificate. If you're testing HTTPS
against this container, then you'll probably need to pass it to your WebDAV
client library in order to get it to connect. If it works without passing the
certificate, then your client library accepts self-signed certificates without
being told explicitly to trust the particular certificate, which is a security
problem that should be fixed!

In order to get that to work, the `cerulean_webdav.crt` file is copied to the
`cerulean-base` directory/container, where it's available in `/home/cerulean`.
