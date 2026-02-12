#!/bin/bash

# Copy SSH keys from /tmp/.ssh to ~/.ssh and set correct permissions

SOURCE_DIR="/tmp/.ssh"
TARGET_DIR="$HOME/.ssh"

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory $SOURCE_DIR does not exist"
    exit 1
fi

# Create target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Copy all files from source to target
cp -r "$SOURCE_DIR"/* "$TARGET_DIR"/

# Set correct permissions for .ssh directory
chmod 700 "$TARGET_DIR"

# Set correct permissions for private keys (id_* files without .pub extension)
find "$TARGET_DIR" -type f -name "id_*" ! -name "*.pub" -exec chmod 600 {} \;

# Set correct permissions for public keys (*.pub files)
find "$TARGET_DIR" -type f -name "*.pub" -exec chmod 644 {} \;

# Set correct permissions for known_hosts and config files
[ -f "$TARGET_DIR/known_hosts" ] && chmod 644 "$TARGET_DIR/known_hosts"
[ -f "$TARGET_DIR/config" ] && chmod 600 "$TARGET_DIR/config"

echo "SSH keys copied and permissions set successfully"
