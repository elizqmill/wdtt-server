#!/bin/bash
# Usage: ./deploy.sh user@host [/path/to/binary]
set -euo pipefail

BINARY="${2:-./wdtt-server}"
HOST="$1"

if [ ! -f "$BINARY" ]; then
    echo "Binary not found: $BINARY"
    echo "Run 'make build-amd64' first"
    exit 1
fi

echo "[DEPLOY] Uploading $BINARY to $HOST..."
scp "$BINARY" "$HOST:/tmp/wdtt-server"

echo "[DEPLOY] Installing on $HOST..."
ssh "$HOST" "
    set -e
    install -m 0755 /tmp/wdtt-server /usr/local/bin/wdtt-server
    systemctl daemon-reload
    systemctl restart wdtt
    sleep 2
    systemctl status wdtt --no-pager
"

echo "[DEPLOY] Done"
