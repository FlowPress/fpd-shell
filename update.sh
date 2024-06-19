#!/bin/bash

cd ~/.fpd-shell
git pull origin main

# Update the version file
echo $FPD_SHELL_VERSION > ~/.fpd-shell/.fpd-shell-version

echo "FPD Shell updated successfully!"
