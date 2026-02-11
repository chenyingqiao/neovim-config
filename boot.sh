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

# 根据系统选择配置文件
COMPOSE_FILE=""
if [ "$OS" = "windows" ]; then
    COMPOSE_FILE="docker-compose-windows.yml"
else
    COMPOSE_FILE="docker-compose.yml"
fi

if [ ! -f "$COMPOSE_FILE" ]; then
    echo "Error: $COMPOSE_FILE not found!"
    exit 1
fi

echo "Detected OS: $OS"
echo "Using compose file: $COMPOSE_FILE"
echo "Command: $COMMAND"
echo ""

if [ "$COMMAND" = "start" ]; then
    docker compose -f "$COMPOSE_FILE" up -d
    echo ""
    echo "Containers started successfully."
else
    docker compose -f "$COMPOSE_FILE" down
    echo ""
    echo "Containers stopped successfully."
fi
