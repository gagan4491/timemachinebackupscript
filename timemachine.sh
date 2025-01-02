#!/bin/bash

# Define the Volume UUIDs for the drives
BACKUP_UUID="67042DAE-5BB4-468D-8A44-F6BEAD3DA2BF"
TIMEMACHINE_UUID="ED3EB508-7808-4493-888D-43827DC733BB"

# Check if the backup or timemachine drives are mounted
BACKUP_MOUNTED=$(diskutil info /Volumes/backup | grep "Volume UUID" | awk '{print $NF}')
TIMEMACHINE_MOUNTED=$(diskutil info /Volumes/timemachine | grep "Volume UUID" | awk '{print $NF}')

# Log the current UUIDs for debugging
echo "Backup Drive UUID (Mounted): $BACKUP_MOUNTED"
echo "Time Machine Drive UUID (Mounted): $TIMEMACHINE_MOUNTED"
echo "Expected Backup UUID: $BACKUP_UUID"
echo "Expected Time Machine UUID: $TIMEMACHINE_UUID"

# Paths to exclude
EXCLUDED_PATHS=(
    "/Users/gsingh/Documents"
    "/Users/gsingh/Downloads"
    "/Users/gsingh/Desktop"
    "/Users/gsingh/PycharmProjects"
)

# Logic to handle exclusions
if [[ "$BACKUP_MOUNTED" == "$BACKUP_UUID" ]]; then
    echo "Backup drive detected. Setting exclusions for limited backup..."
    for path in "${EXCLUDED_PATHS[@]}"; do
        echo "Excluding: $path"
        sudo tmutil addexclusion -p "$path"
    done
elif [[ "$TIMEMACHINE_MOUNTED" == "$TIMEMACHINE_UUID" ]]; then
    echo "Time Machine drive detected. Ensuring full backup (no exclusions)..."
    for path in "${EXCLUDED_PATHS[@]}"; do
        echo "Removing exclusion: $path"
        sudo tmutil removeexclusion -p "$path"
    done
else
    echo "No recognized Time Machine drive is currently mounted. No action taken."
fi

echo "Operation complete."