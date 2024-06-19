#!/bin/bash

# Function to uninstall Oh My Zsh
uninstall_oh_my_zsh() {
	if [[ -d ~/.oh-my-zsh ]]; then
		sh ~/.oh-my-zsh/tools/uninstall.sh --unattended
		log_success "Oh My Zsh uninstalled."
	fi
}
