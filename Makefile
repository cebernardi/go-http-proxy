
build:
	go build -mod=vendor ./...

run:
	go run -mod=vendor main.go

release:
	@goreleaser --rm-dist

test:
	go test -mod=vendor -coverprofile=coverage.out -cover ./...
