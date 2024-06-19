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

	# Remove FPD Shell sourcing from .zshrc or .bashrc
	if [[ -f ~/.zshrc ]]; then
		sed -i '' '/source ~\/.fpd-shell\/fpd-shell.sh/d' ~/.zshrc
		sed -i '' '/source ~\/.fpd-shell\/.fpd-shellrc/d' ~/.zshrc
		sed -i '' '/ZSH_THEME="gallois"/d' ~/.zshrc
		sed -i '' '/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/d' ~/.zshrc
		sed -i '' '/ZSH=$HOME\/.oh-my-zsh/d' ~/.zshrc
		sed -i '' '/source $ZSH\/oh-my-zsh.sh/d' ~/.zshrc
		log_success "Removed FPD Shell sourcing from .zshrc."
	elif [[ -f ~/.bashrc ]]; then
		sed -i '' '/source ~\/.fpd-shell\/fpd-shell.sh/d' ~/.bashrc
		sed -i '' '/source ~\/.fpd-shell\/.fpd-shellrc/d' ~/.bashrc
		log_success "Removed FPD Shell sourcing from .bashrc."
	fi
}

# Function to uninstall Oh My Zsh
uninstall_oh_my_zsh() {
	if [[ -d ~/.oh-my-zsh ]]; then
		sh ~/.oh-my-zsh/tools/uninstall.sh --unattended
		log_success "Oh My Zsh uninstalled."
	fi
}
