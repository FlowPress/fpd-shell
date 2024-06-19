#!/bin/bash

# Source the .fpd-shellrc file to get logging functions

install_oh_my_zsh() {
	ls -la ~/.fpd-shell/
	source ~/.fpd-shell/.fpd-shellrc
	log_heading "Installing Oh My Zsh..."
	RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
}
