#!/bin/bash

install_fpd_shell() {
	TEMP_DIR=$1

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

	# Ensure the .fpd-shellrc file is sourced correctly
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
		zsh -c "
      source ~/.fpd-shell/util/install_oh_my_zsh.sh
      install_oh_my_zsh

      source ~/.fpd-shell/util/set_theme_and_plugins.sh
      set_oh_my_zsh_theme_and_plugins
    "
	fi

	# Add cron job to update FPD Shell daily
	crontab -l > mycron
	if ! grep -q "~/.fpd-shell/update.sh" mycron; then
		echo "0 0 * * * ~/.fpd-shell/update.sh" >> mycron
		crontab mycron || echo "Could not update crontab. Please add the following line to your crontab manually:
0 0 * * * ~/.fpd-shell/update.sh"
	fi
	rm mycron


}


# Add cron job to update FPD Shell daily
(crontab -l ; echo "0 0 * * * ~/.fpd-shell/update.sh") | crontab -

echo "FPD Shell installed and daily update scheduled!"