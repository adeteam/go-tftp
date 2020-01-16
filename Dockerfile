FROM alpine:3

ADD build/go-tftp-linux-amd64 /usr/sbin/go-tftp
RUN chmod a+x /usr/sbin/go-tftp

CMD ["/usr/sbin/go-tftp", "--port", "69", "--path", "/var/lib/tftpboot"]