FROM golang:latest

COPY ./Init.sh ./Init.sh

# Install needed tools
RUN ./Init.sh

COPY scripts/ ./scripts/

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["scripts/bootstrap.sh"]
