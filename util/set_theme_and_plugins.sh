#!/bin/bash

set_oh_my_zsh_theme_and_plugins() {
	# Create .zshrc if it doesn't exist
	if [ ! -f ~/.zshrc ]; then
		touch ~/.zshrc
	fi

	# echo "Select a theme for Oh My Zsh:"
	# echo "1) robbyrussell"
	# echo "2) agnoster"
	# echo "3) gallois"
	# echo "4) avit"
	# echo "5) random"
	# read -p "Enter the number corresponding to your choice: " theme_choice

	# case $theme_choice in
	# 1) ZSH_THEME="robbyrussell" ;;
	# 2) ZSH_THEME="agnoster" ;;
	# 3) ZSH_THEME="gallois" ;;
	# 4) ZSH_THEME="avit" ;;
	# 5) ZSH_THEME="random" ;;
	# *)
	# 	echo "Invalid choice, defaulting to robbyrussell"
	# 	ZSH_THEME="robbyrussell"
	# 	;;
	# esac

	ZSH_THEME="gallois"

	echo "ZSH_THEME=\"$ZSH_THEME\"" >>~/.zshrc

	echo "plugins=(git zsh-autosuggestions zsh-syntax-highlighting)" >>~/.zshrc

	echo "Theme set to $theme and plugins configured."

	cat ~/.zshrc
}
