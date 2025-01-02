#!/bin/bash

# List of paths to ensure no exclusions
EXCLUDED_PATHS=(
    "/Users/gsingh/Documents"
    "/Users/gsingh/Downloads"
    "/Users/gsingh/Desktop"
    "/Users/gsingh/PycharmProjects"
)

echo "Removing all exclusions persistently..."

for path in "${EXCLUDED_PATHS[@]}"; do
    echo "Removing exclusion for: $path"
    sudo tmutil removeexclusion -p "$path"
done

echo "All exclusions have been removed persistently."