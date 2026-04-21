#!/bin/bash

set -e

# 解析参数
COMMAND="${1:-start}"

if [ "$COMMAND" != "start" ] && [ "$COMMAND" != "down" ]; then
    echo "Usage: $0 [start|down]"
    echo "  start - Start containers (default)"
    echo "  down  - Stop and remove containers"
    exit 1
fi

# 检测操作系统
OS=""
case "$(uname -s)" in
    Linux*)     OS="linux";;
    Darwin*)    OS="macos";;
    CYGWIN*)    OS="windows";;
    MINGW*)     OS="windows";;
    MSYS*)      OS="windows";;
    *)          OS="unknown";;
esac

COMPOSE_FILE="docker-compose.yml"

if [ ! -f "$COMPOSE_FILE" ]; then
    echo "Error: $COMPOSE_FILE not found!"
    exit 1
fi

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

echo "Detected OS: $OS"
echo "Command: $COMMAND"
echo ""

if [ "$COMMAND" = "start" ]; then
    docker compose -f "$COMPOSE_FILE" up -d
    echo ""
    echo "Containers started successfully."
    echo ""

    echo "Copying files to nvim..."
    if [ "$OS" = "windows" ]; then
        pwsh "$SCRIPT_DIR/script/docker-cp.ps1"
    else
        bash "$SCRIPT_DIR/script/docker-cp.sh"
    fi
    echo ""

    echo "Running ssh-init.sh in nvim..."
    docker exec nvim bash /tmp/script/ssh-init.sh
    echo ""

    echo "Done."
else
    docker compose -f "$COMPOSE_FILE" down
    echo ""
    echo "Containers stopped successfully."
fi
