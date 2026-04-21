#!/bin/bash
set -e

CONTAINER="nvim"
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

echo "Copying files to container: $CONTAINER"

docker cp "$HOME/.ssh" "$CONTAINER:/tmp/.ssh"
echo "  [done] ~/.ssh -> /tmp/.ssh"

docker cp "$SCRIPT_DIR" "$CONTAINER:/tmp/script"
echo "  [done] $SCRIPT_DIR -> /tmp/script"

echo "All files copied successfully."
