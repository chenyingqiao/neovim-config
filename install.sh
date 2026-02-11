#!/bin/bash

set -e

cd script
chmod +x download-deps.sh
./download-deps.sh
cd ..

echo "=== Docker Build Configuration ==="
echo ""

# Platform selection
echo "Select platform:"
echo "1) linux/amd64"
echo "2) linux/arm64"
read -p "Enter choice [1-2] (default: 1): " platform_choice

case "$platform_choice" in
  2)
    PLATFORM="linux/arm64"
    ;;
  *)
    PLATFORM="linux/amd64"
    ;;
esac

echo "Selected platform: $PLATFORM"
echo ""

# Proxy settings
read -p "Enable proxy? [y/N] (default: N): " enable_proxy

BUILD_ARGS=""
if [[ "$enable_proxy" =~ ^[Yy]$ ]]; then
  read -p "Enter proxy host:port (default: 127.0.0.1:7890): " proxy_addr
  PROXY_ADDR="${proxy_addr:-127.0.0.1:7890}"

  read -p "Use SOCKS5 for all_proxy? [Y/n] (default: Y): " use_socks
  if [[ "$use_socks" =~ ^[Nn]$ ]]; then
    ALL_PROXY="http://$PROXY_ADDR"
  else
    ALL_PROXY="socks5://$PROXY_ADDR"
  fi

  BUILD_ARGS="--build-arg https_proxy=http://$PROXY_ADDR --build-arg http_proxy=http://$PROXY_ADDR --build-arg all_proxy=$ALL_PROXY"
  echo "Proxy enabled: $PROXY_ADDR"
else
  echo "Proxy disabled"
fi
echo ""

# Image name
read -p "Enter image name (default: my-nvim): " image_name
IMAGE_NAME="${image_name:-my-nvim}"
echo "Image name: $IMAGE_NAME"
echo ""

# Confirm and build
echo "=== Build Summary ==="
echo "Platform: $PLATFORM"
echo "Image: $IMAGE_NAME"
if [[ -n "$BUILD_ARGS" ]]; then
  echo "Proxy: enabled"
else
  echo "Proxy: disabled"
fi
echo ""
read -p "Proceed with build? [Y/n]: " confirm

if [[ "$confirm" =~ ^[Nn]$ ]]; then
  echo "Build cancelled."
  exit 0
fi

echo ""
echo "Starting build..."
echo ""

docker buildx build \
  --progress plain \
  --load \
  --platform "$PLATFORM" \
  $BUILD_ARGS \
  -t "$IMAGE_NAME" \
  -f Dockerfile ./

echo ""
echo "Build complete: $IMAGE_NAME"
