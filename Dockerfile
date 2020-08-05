FROM golang:alpine as builder


WORKDIR /go-http-proxy
COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -mod=vendor ./...
FROM alpine

RUN apk add --no-cache ca-certificates openssl
COPY --from=builder /go-http-proxy/go-http-proxy /bin/http_proxy

HEALTHCHECK --interval=5s --timeout=3s --retries=3 CMD curl -f http://localhost:8080 || exit 1

CMD ["/bin/http_proxy"]
