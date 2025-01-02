#!/bin/bash

# Define the IDs for your drives
BACKUP_ID="D25E2F59-0CFB-4D57-B07F-326ECC887758"
CURRENT_ID=$(tmutil destinationinfo | grep "ID" | awk '{print $NF}')

if [[ $CURRENT_ID == $BACKUP_ID ]]; then
    echo "Setting exclusions for backup drive..."
    sudo tmutil addexclusion -p /Users/gsingh/Documents
    sudo tmutil addexclusion -p /Users/gsingh/Downloads
    sudo tmutil addexclusion -p /Users/gsingh/Desktop
    sudo tmutil addexclusion -p /Users/gsingh/PycharmProjects

else
    echo "Removing exclusions for full backup drive..."
    sudo tmutil removeexclusion /Users/gsingh/Documents
    sudo tmutil removeexclusion /Users/gsingh/Downloads
    sudo tmutil removeexclusion /Users/gsingh/Desktop
    sudo tmutil removeexclusion /Users/gsingh/PycharmProjects


fi