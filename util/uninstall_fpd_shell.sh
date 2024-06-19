#!/bin/bash

# Source the .fpd-shellrc file to get logging functions and other configurations
if [[ -f ~/.fpd-shell/.fpd-shellrc ]]; then
	source ~/.fpd-shell/.fpd-shellrc
fi

uninstall_fpd_shell() {
	log_heading "Uninstalling FPD Shell..."

	# Remove FPD Shell directory
	if [[ -d ~/.fpd-shell ]]; then
		rm -rf ~/.fpd-shell
		log_success "FPD Shell directory removed."
	fi
}

# Function to uninstall Oh My Zsh
uninstall_oh_my_zsh() {
	if [[ -d ~/.oh-my-zsh ]]; then
		sh ~/.oh-my-zsh/tools/uninstall.sh --unattended
		log_success "Oh My Zsh uninstalled."
	fi
}
