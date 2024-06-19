#!/bin/bash

# Source the .fpd-shellrc file to get logging functions and other configurations
if [[ -f ~/.fpd-shell/.fpd-shellrc ]]; then
	source ~/.fpd-shell/.fpd-shellrc
fi

uninstall_fpd_shell() {
	TEMP_DIR=$1

	log_heading "Uninstalling FPD Shell..."

	# Remove FPD Shell directory
	if [[ -d ~/.fpd-shell ]]; then
		rm -rf ~/.fpd-shell
		log_success "FPD Shell directory removed."
	fi

	# Uninstall Oh My Zsh if it is installed
	if [[ -d ~/.oh-my-zsh ]]; then
		echo "Uninstalling Oh My Zsh..."
		zsh -c "
      source '$TEMP_DIR/uninstall_oh_my_zsh.sh'
      uninstall_oh_my_zsh
    "
	fi

	# Restore .zshrc from backup
	restore_zshrc
}
