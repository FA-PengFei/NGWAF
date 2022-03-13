from golang:1.17.2-alpine3.14

WORKDIR /app
COPY . .
RUN go get -d -v ./...
RUN go install -v ./...
RUN go build

# EXPOSE 5000

CMD ["drupot", "-c", "config.toml.example"]
