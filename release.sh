#!/bin/bash

# Define the source and destination directories
# Source: The 'public' directory (Hugo's output) within the current directory
SOURCE_DIR="./public"
# Destination: The target blog directory
DEST_DIR="/Volumes/websites/blog"

# --- Build the Hugo Site ---

echo "Building Hugo site..."
# Run the hugo command to generate the site into ./public
hugo

# Check the exit status of the hugo command
HUGO_EXIT_STATUS=$?
if [ $HUGO_EXIT_STATUS -ne 0 ]; then
  echo "Error: Hugo build failed with exit status $HUGO_EXIT_STATUS."
  exit 1
fi
echo "Hugo build completed successfully."

# --- Safety Checks (Optional but Recommended) ---

# Check if the source directory exists (it should after a successful hugo build)
if [ ! -d "$SOURCE_DIR" ]; then
  echo "Error: Source directory '$SOURCE_DIR' not found even after Hugo build."
  exit 1
fi

# Check if the destination directory exists
if [ ! -d "$DEST_DIR" ]; then
  echo "Error: Destination directory '$DEST_DIR' not found."
  # Optional: Uncomment the next line to create the destination if it doesn't exist
  # mkdir -p "$DEST_DIR" || { echo "Error: Could not create destination directory."; exit 1; }
  # Optional: If you don't want to create it, just exit
  exit 1
fi

# --- The Copy Command ---

echo "Copying contents from '$SOURCE_DIR' to '$DEST_DIR'..."

# Use cp (copy) command:
# -R: Recursive - copy directories and their contents.
# -p: Preserve - keep original file modes, ownership, and timestamps.
# -v: Verbose - show which files are being copied.
# Source path ends with '/.' to copy the *contents* of the directory,
# not the directory itself.
# This will overwrite files in the destination if they also exist in the source,
# but it will NOT delete files in the destination that are not in the source.
cp -Rpv "$SOURCE_DIR/." "$DEST_DIR/"

# Check the exit status of the cp command
CP_EXIT_STATUS=$?
if [ $CP_EXIT_STATUS -eq 0 ]; then
  echo "Copy completed successfully."
else
  echo "Error: Copy command failed with exit status $CP_EXIT_STATUS."
  exit 1
fi

exit 0
