#!/bin/bash

set_oh_my_zsh_theme_and_plugins() {
	echo "Select a theme for Oh My Zsh or type your custom theme:"
	echo "1) robbyrussell"
	echo "2) agnoster"
	echo "3) gallois"
	echo "4) avit"
	echo "5) random"
	echo "6) Custom theme"
	echo -n "Enter the number corresponding to your choice or type your theme name: "
	read theme_choice

	case $theme_choice in
	1)
		theme="robbyrussell"
		;;
	2)
		theme="agnoster"
		;;
	3)
		theme="gallois"
		;;
	4)
		theme="avit"
		;;
	5)
		theme="random"
		;;
	6)
		echo -n "Enter your custom theme name: "
		read custom_theme
		theme="$custom_theme"
		;;
	*)
		echo "Invalid choice, defaulting to robbyrussell"
		theme="robbyrussell"
		;;
	esac

	# Create .zshrc if it doesn't exist
	if [ ! -f ~/.zshrc ]; then
		touch ~/.zshrc
	fi

	# Set the theme in .zshrc
	sed -i.bak "s/^ZSH_THEME=.*/ZSH_THEME=\"$theme\"/" ~/.zshrc

	# Add plugins to .zshrc before sourcing oh-my-zsh
	sed -i.bak '/^source \$ZSH\/oh-my-zsh.sh/i\plugins=(git zsh-autosuggestions zsh-syntax-highlighting)' ~/.zshrc

	echo "Theme set to $theme and plugins configured."
}
