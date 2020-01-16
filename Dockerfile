FROM alpine:3

RUN apk add curl
RUN curl https://github.com/vcabbage/go-tftp/archive/v1.0.0.zip --output /tmp/v1.0.0.zip
