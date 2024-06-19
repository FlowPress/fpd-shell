#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Define the URL base for the utility scripts
GITHUB_BASE_URL="https://raw.githubusercontent.com/FlowPress/fpd-shell/main/util"

# Define the utility scripts to download
UTIL_SCRIPTS=("install_oh_my_zsh.sh" "set_theme_and_plugins.sh" "uninstall_fpd_shell.sh" "print_success_message.sh")

# Create a temporary directory to store the utility scripts
TEMP_DIR=$(mktemp -d)

echo "Temporary directory created at $TEMP_DIR"

# Function to download utility scripts
download_util_scripts() {
  for script in "${UTIL_SCRIPTS[@]}"; do
    echo "Downloading $script"
    curl -fsSL "$GITHUB_BASE_URL/$script?$(date +%s)" -o "$TEMP_DIR/$script"
    if [ ! -f "$TEMP_DIR/$script" ]; then
      echo "Failed to download $script"
      exit 1
    fi
  done
}

# Download the utility scripts
download_util_scripts

# Check if utility scripts exist in the temporary directory
for script in "${UTIL_SCRIPTS[@]}"; do
  if [ -f "$TEMP_DIR/$script" ]; then
    echo "$script downloaded successfully"
  else
    echo "$script failed to download"
    exit 1
  fi
done

# Source the utility scripts
echo "Sourcing utility scripts"
source "$TEMP_DIR/install_oh_my_zsh.sh"
source "$TEMP_DIR/set_theme_and_plugins.sh"
source "$TEMP_DIR/uninstall_fpd_shell.sh"
source "$TEMP_DIR/print_success_message.sh"

# Prompt user for installation or uninstallation
read -p "Do you want to install or uninstall FPD Shell? (i/u): " action

case $action in
  i|install)
    read -p "Do you want to install Oh My Zsh? (y/n): " install_omz
    if [ "$install_omz" == "y" ]; then
      if [ -d ~/.oh-my-zsh ]; then
        echo "The \$ZSH folder already exists ($HOME/.oh-my-zsh)."
        read -p "Do you want to remove it and reinstall Oh My Zsh? (y/n): " remove_zsh
        if [ "$remove_zsh" == "y" ]; then
          rm -rf ~/.oh-my-zsh
          install_oh_my_zsh
        else
          echo "Skipping Oh My Zsh installation."
        fi
      else
        install_oh_my_zsh
      fi
      set_oh_my_zsh_theme_and_plugins
      echo 'print_success_message' >> ~/.zshrc
    else
      print_success_message
    fi

    # Clone the repository
    if [ -d ~/.fpd-shell ]; then
      echo "~/.fpd-shell already exists. Please remove it or choose another directory."
      read -p "Do you want to remove ~/.fpd-shell and proceed with the installation? (y/n): " remove_fpd_shell
      if [ "$remove_fpd_shell" == "y" ]; then
        rm -rf ~/.fpd-shell
        echo "Cloning the FPD Shell repository..."
        git clone https://github.com/FlowPress/fpd-shell.git ~/.fpd-shell
      else
        echo "Skipping FPD Shell installation."
      fi
    else
      echo "Cloning the FPD Shell repository..."
      git clone https://github.com/FlowPress/fpd-shell.git ~/.fpd-shell
    fi

    # Source the main shell script in .bashrc or .zshrc
    if [ -f ~/.zshrc ]; then
      echo 'source ~/.fpd-shell/fpd-shell.sh' >> ~/.zshrc
      source ~/.zshrc
    elif [ -f ~/.bashrc ]; then
      echo 'source ~/.fpd-shell/fpd-shell.sh' >> ~/.bashrc
      source ~/.bashrc
    else
      # Default to creating .bashrc if neither exists
      echo 'source ~/.fpd-shell/fpd-shell.sh' >> ~/.bashrc
      source ~/.bashrc
    fi
    ;;
  u|uninstall)
    uninstall_fpd_shell
    ;;
  *)
    echo "Invalid option. Please choose 'i' for install or 'u' for uninstall."
    ;;
esac

# Clean up temporary directory
echo "Cleaning up temporary directory"
rm -rf "$TEMP_DIR"
