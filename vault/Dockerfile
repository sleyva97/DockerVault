# Build Vault
FROM golang:1
ENV version 1.0.0
RUN mkdir -p $GOPATH/src/github.com/hashicorp && \
      cd $GOPATH/src/github.com/hashicorp && \
      git clone https://github.com/hashicorp/vault.git
WORKDIR /go/src/github.com/hashicorp/vault
RUN make bootstrap
RUN make dev
RUN cp $(which vault) /vault

# Inject Vault into container
FROM scratch
ENV VAULT_ADDR='http://127.0.0.1:8200'
COPY example.hcl /etc/config.hcl
COPY --from=0 /vault /bin/vault
ENTRYPOINT ["vault", "server", "-config=/etc/config.hcl"]
