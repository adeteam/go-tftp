FROM golang:alpine3.11

ADD . /tmp/go-tftp

# install and build
RUN apk add make
RUN cd /tmp/go-tftp && make
RUN mv /tmp/go-tftp/build/go-tftp-linux-amd64 /usr/sbin/go-tftp && chmod a+x /usr/sbin/go-tftp

# cleanup and remove unuse packages
RUN apk del make
RUN rm -rf /go && rm -rf /usr/local/go

CMD ["/usr/sbin/go-tftp", "--port", "69", "--path", "/var/lib/tftpboot"]