FROM golang:latest

COPY ./Init.sh ./Init.sh

# Install needed tools
RUN ./Init.sh

COPY Scripts/ ./Scripts/

COPY example.hcl /etc/config.hcl

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["Scripts/bootstrap.sh"]
