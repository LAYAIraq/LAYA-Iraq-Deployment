FROM alpine:3.15.0
MAINTAINER Constantin Mauf-Clausen

RUN apk add --no-cache nginx openssl gettext

ADD nginx.conf.template /
ADD configure_and_start.sh /

ENTRYPOINT ["/configure_and_start.sh"]
