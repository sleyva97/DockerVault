FROM golang:1

ENV VERSION=1.0.0

RUN mkdir -p $GOPATH/src/github.com/hashicorp && \
      cd $GOPATH/src/github.com/hashicorp && \
      git clone https://github.com/hashicorp/consul.git && \
      cd consul && \
      go get github.com/mitchellh/gox

RUN cd $GOPATH/src/github.com/mitchellh/ && \
      go install ./...

WORKDIR /go/src/github.com/hashicorp/consul

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o consul .

RUN cp ./consul /consul

FROM scratch
COPY --from=0 /consul /bin/consul
ENTRYPOINT ["consul", "agent", "-data-dir", "/tmp/consul", "-client", "0.0.0.0", "-bind", "127.0.0.1", "retry-join", "consul-server:8301" ]
