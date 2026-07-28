.PHONY: all clean

APP=wdtt-server
VERSION=$(shell git describe --tags --always 2>/dev/null || echo "dev")
LDFLAGS=-ldflags="-s -w -X main.version=$(VERSION)"

all: build-amd64 build-arm64

build-amd64:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build $(LDFLAGS) -o $(APP) .

build-arm64:
	CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build $(LDFLAGS) -o $(APP)-arm64 .

clean:
	rm -f $(APP) $(APP)-arm64
