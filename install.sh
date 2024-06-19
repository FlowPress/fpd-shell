#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status

# Define the URL base for the repository
GITHUB_BASE_URL="https://raw.githubusercontent.com/FlowPress/fpd-shell/main"

# Define the utility scripts to download initially
INITIAL_UTIL_SCRIPTS=("backup_restore_zshrc.sh" "install_fpd_shell.sh")

# Create a temporary directory to store the utility scripts
TEMP_DIR=$(mktemp -d)

echo "Temporary directory created at $TEMP_DIR"

# Function to download a file
download_file() {
	local url=$1
	local dest=$2
	echo "Downloading $url"
	curl -H 'Cache-Control: no-cache' -H 'Pragma: no-cache' -fsSL "$url?$(date +%s)" -o "$dest"
	if [ ! -f "$dest" ]; then
		echo "Failed to download $url"
		exit 1
	fi
}

# Download the version file
download_file "$GITHUB_BASE_URL/VERSION" "$TEMP_DIR/VERSION"
VERSION=$(cat "$TEMP_DIR/VERSION")
echo "FPD Shell version: $VERSION"

# Function to download initial utility scripts
download_initial_util_scripts() {
	for script in "${INITIAL_UTIL_SCRIPTS[@]}"; do
		download_file "$GITHUB_BASE_URL/util/$script" "$TEMP_DIR/$script"
	done
}

# Download the initial utility scripts
download_initial_util_scripts

# Check if initial utility scripts exist in the temporary directory
for script in "${INITIAL_UTIL_SCRIPTS[@]}"; do
	if [ -f "$TEMP_DIR/$script" ]; then
		echo "$script downloaded successfully"
	else
		echo "$script failed to download"
		exit 1
	fi
done

# Source initial utility scripts
for script in "${INITIAL_UTIL_SCRIPTS[@]}"; do
	source "$TEMP_DIR/$script"
done

# Prompt user for installation or uninstallation
read -p "Do you want to install or uninstall FPD Shell? (i/u): " action

case $action in
i | install)
	install_fpd_shell "$TEMP_DIR"
	;;
u | uninstall)
	if [[ -f ~/.fpd-shell/.fpd-shellrc ]]; then
		source ~/.fpd-shell/.fpd-shellrc
		source ~/.fpd-shell/util/uninstall_fpd_shell.sh
		uninstall_fpd_shell
	else
		echo "Error: .fpd-shellrc file not found. Cannot proceed with uninstallation."
		exit 1
	fi
	;;
*)
	echo "Invalid option. Please choose 'i' for install or 'u' for uninstall."
	;;
esac

# Clean up temporary directory
echo "Cleaning up temporary directory"
rm -rf "$TEMP_DIR"
