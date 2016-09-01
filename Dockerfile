FROM gcr.io/stacksmith-images/ubuntu:14.04-r8

MAINTAINER Bitnami <containers@bitnami.com>

ENV BITNAMI_APP_NAME=wordpress \
    BITNAMI_IMAGE_VERSION=4.6-r1 \
    PATH=/opt/bitnami/php/bin:/opt/bitnami/mysql/bin/:$PATH

# Additional modules required
RUN bitnami-pkg unpack apache-2.4.23-2 --checksum 80605a5b1a3103cefc125cb150cc08a017702d0c1e3ea5f806540ad91c77cf38
RUN bitnami-pkg install php-5.6.25-0 --checksum f0e8d07d155abdb5d6843931d3ffbf9b4208fff248c409444fdd5a8e3a3da01d
RUN bitnami-pkg install libphp-5.6.21-2 --checksum 83d19b750b627fa70ed9613504089732897a48e1a7d304d8d73dec61a727b222
RUN bitnami-pkg install mysql-client-10.1.13-4 --checksum 14b45c91dd78b37f0f2366712cbe9bfdf2cb674769435611955191a65dbf4976

# Install wordpress
RUN bitnami-pkg unpack wordpress-4.6-1 --checksum 8e809d1719bbef52b89dd909350702f463d2e0c8afc2bb46642f4b0552dc51a2

COPY rootfs /

VOLUME ["/bitnami/wordpress", "/bitnami/apache"]

EXPOSE 80 443

ENTRYPOINT ["/app-entrypoint.sh"]

CMD ["harpoon", "start", "--foreground", "apache"]
