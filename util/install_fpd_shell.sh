#!/bin/bash

install_fpd_shell() {
	# Check if the directory exists for installation
	if [[ -d ~/.fpd-shell ]]; then
		echo "~/.fpd-shell already exists. Please remove it or choose another directory."
		read -p "Do you want to remove ~/.fpd-shell and proceed with the installation? (y/n): " remove_fpd_shell
		if [[ "$remove_fpd_shell" == "y" ]]; then
			rm -rf ~/.fpd-shell
		else
			echo "Installation aborted."
			exit 1
		fi
	fi

	echo "Cloning the FPD Shell repository..."
	git clone https://github.com/FlowPress/fpd-shell.git ~/.fpd-shell

	# Source the .fpd-shellrc file from the cloned repository
	if [[ -f ~/.fpd-shell/.fpd-shellrc ]]; then
		echo "Sourcing .fpd-shellrc"
		source ~/.fpd-shell/.fpd-shellrc
	else
		echo "Error: .fpd-shellrc file not found in the cloned repository."
		exit 1
	fi

	# Backup .zshrc
	backup_zshrc

	# Source the main shell script in .zshrc or .bashrc
	if [[ -f ~/.zshrc ]]; then
		echo 'source ~/.fpd-shell/fpd-shell.sh' >>~/.zshrc
		echo 'source ~/.fpd-shell/.fpd-shellrc' >>~/.zshrc
		source ~/.zshrc
	elif [[ -f ~/.bashrc ]]; then
		echo 'source ~/.fpd-shell/fpd-shell.sh' >>~/.bashrc
		echo 'source ~/.fpd-shell/.fpd-shellrc' >>~/.bashrc
		source ~/.bashrc
	else
		# Default to creating .zshrc if neither exists
		echo 'source ~/.fpd-shell/fpd-shell.sh' >>~/.zshrc
		echo 'source ~/.fpd-shell/.fpd-shellrc' >>~/.zshrc
		source ~/.zshrc
	fi

	# Install Oh My Zsh if user opts in
	read -p "Do you want to install Oh My Zsh? (y/n): " install_omz
	if [[ "$install_omz" == "y" ]]; then
		if [[ -d ~/.oh-my-zsh ]]; then
			echo "The \$ZSH folder already exists ($HOME/.oh-my-zsh)."
			read -p "Do you want to remove it and reinstall Oh My Zsh? (y/n): " remove_zsh
			if [[ "$remove_zsh" == "y" ]]; then
				rm -rf ~/.oh-my-zsh
			fi
		fi

		# Run the Oh My Zsh installation in a zsh subshell
		zsh <<EOF
      source "$TEMP_DIR/install_oh_my_zsh.sh"
      install_oh_my_zsh

      source "$TEMP_DIR/set_theme_and_plugins.sh"
      set_oh_my_zsh_theme_and_plugins

      source "$TEMP_DIR/print_success_message.sh"
      print_success_message
EOF

	fi
}
