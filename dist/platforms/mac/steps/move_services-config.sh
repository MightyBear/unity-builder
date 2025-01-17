#!/usr/bin/env bash
UNITY_PROJECT_PATH="$GITHUB_WORKSPACE/$PROJECT_PATH"
ORIGINAL_FILE="$UNITY_PROJECT_PATH/services-config.json"
TARGET_DIR="/Library/Application Support/Unity/config"

# Create config folder
sudo /bin/mkdir -p "$TARGET_DIR"

# Move file
if [[ -e "$ORIGINAL_FILE" ]]; then
    sudo /bin/mv "$ORIGINAL_FILE" "$TARGET_DIR"
    printf "services-config.json moved to $TARGET_DIR"
else
    printf "services-config.json not found in $UNITY_PROJECT_PATH"
fi
