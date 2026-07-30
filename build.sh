#!/bin/bash
set -euo pipefail

APP=maxtunnel-server
VERSION=$(git describe --tags --always 2>/dev/null || echo "dev")
LDFLAGS="-ldflags=-s -w -X main.version=$VERSION"

echo "[BUILD] $APP v$VERSION"

echo "  → amd64..."
CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build $LDFLAGS -o "$APP" .

echo "  → arm64..."
CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build $LDFLAGS -o "${APP}-arm64" .

echo "[OK]"
ls -lh "$APP" "${APP}-arm64"
