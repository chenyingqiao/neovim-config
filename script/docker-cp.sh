#!/bin/bash
set -e

CONTAINER="nvim-lerko"
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

echo "Copying files to container: $CONTAINER"

docker cp "$HOME/.claude" "$CONTAINER:/root/.claude"
echo "  [done] ~/.claude -> /root/.claude"

docker cp "$HOME/.ssh" "$CONTAINER:/tmp/.ssh"
echo "  [done] ~/.ssh -> /tmp/.ssh"

docker cp "$SCRIPT_DIR" "$CONTAINER:/tmp/script"
echo "  [done] $SCRIPT_DIR -> /tmp/script"

PROJECT_DIR=$(dirname "$SCRIPT_DIR")
docker exec "$CONTAINER" mkdir -p /app/data
docker cp "$PROJECT_DIR/data/appsettings.json" "$CONTAINER:/app/data/appsettings.json"
echo "  [done] $PROJECT_DIR/data/appsettings.json -> /app/data/appsettings.json"

echo "All files copied successfully."
