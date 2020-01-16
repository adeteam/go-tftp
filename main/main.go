package main

import (
	"flag"
	"fmt"
	"log"
	"pack.ag/tftp"
)

var port int
var path string
var singlePort bool

func init() {
	flag.IntVar(&port, "port", 69, "TCP/UDP port to listen on")
	flag.StringVar(&path, "path", "/var/lib/tftpboot", "Directory path to serve")
	flag.BoolVar(&singlePort, "single-port", false, "Whether to restrict to only a single port for communication")
}

func main() {
	// parse the arguments
	flag.Parse()
	opts := []tftp.ServerOpt{}

	if singlePort {
		log.Print("running in single port mode")
		opts = append(opts, tftp.ServerSinglePort(true))
	}

	server, err := tftp.NewServer(
		fmt.Sprintf(":%d", port),
		opts...
	)

	if err != nil {
		log.Fatal(err)
	}

	log.Printf("setting path to %s", path)
	server.WriteHandler(tftp.FileServer(path))
	server.ReadHandler(tftp.FileServer(path))

	log.Printf("starting server and listening on port %d", port)
	log.Fatal(server.ListenAndServe())
}