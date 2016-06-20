# Start from a Debian image with the latest version of Go installed
# and a workspace (GOPATH) configured at /go.
FROM golang

# Copy the local package files to the container's workspace.
ADD . /work/src/github.com/marloncampos/webservices

# Build the webservices command inside the container.
# (You may fetch or manage dependencies here,
# either manually or with a tool like "godep".)
RUN apk add --no-cache git \
	&& go get github.com/CiscoZeus/go-zeusclient \
	&& apk del git
RUN go install github.com/marloncampos/webservices

# Run the web command by default when the container starts.
ENTRYPOINT /work/bin/webservices

# Document that the service listens on port 8080.
EXPOSE 8080