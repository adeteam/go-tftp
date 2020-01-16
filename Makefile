# Borrowed from: 
# https://github.com/silven/go-example/blob/master/Makefile
# https://vic.demuzere.be/articles/golang-makefile-crosscompile/

# To be set
ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
SRC_BASE=${ROOT_DIR}
SRC_MAIN_DIR=${SRC_BASE}/main
BINARY=go-tftp
BIN_DIR=${SRC_BASE}/build
GOARCH=amd64

# Setup the -ldflags option for go build here, interpolate the variable values
LDFLAGS = -ldflags "-s -w"

# Build the project
all: ready clean linux

ready:
	BIN_DIR=${BIN_DIR}; \
	if [ ! -d "$${BIN_DIR}" ]; then \
	    mkdir $${BIN_DIR}; \
	fi

linux: 
	cd ${SRC_MAIN_DIR}; \
	GOOS=linux GOARCH=${GOARCH} go build ${LDFLAGS} -o ${BIN_DIR}/${BINARY}-linux-${GOARCH} . ; \
	cd - >/dev/null

clean:
	-rm -f ${BIN_DIR}/${BINARY}-*

.PHONY: ready linux clean
