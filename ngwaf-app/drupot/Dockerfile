from golang:1.17.2-alpine3.14

RUN addgroup -S wafuser && adduser -S wafuser -G wafuser
USER wafuser

WORKDIR /app
COPY . .

RUN go get -d -v ./...
RUN go install -v ./...
RUN go build

CMD ["drupot", "-c", "config.toml.example"]
