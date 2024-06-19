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
    #     1) ZSH_THEME="robbyrussell" ;;
    #     2) ZSH_THEME="agnoster" ;;
    #     3) ZSH_THEME="gallois" ;;
    #     4) ZSH_THEME="avit" ;;
    #     5) ZSH_THEME="random" ;;
    #     *)
    #         echo "Invalid choice, defaulting to robbyrussell"
    #         ZSH_THEME="robbyrussell"
    #         ;;
    # esac

	        ZSH_THEME="gallois"

    # Set the theme in .zshrc
    # if grep -q "^ZSH_THEME=" ~/.zshrc; then
    #     sed -i.bak "s/^ZSH_THEME=.*/ZSH_THEME=\"$ZSH_THEME\"/" ~/.zshrc
    # else
        echo "ZSH_THEME=\"$ZSH_THEME\"" >> ~/.zshrc
    # fi

    # Add plugins to .zshrc before sourcing oh-my-zsh
    if ! grep -q "plugins=(git zsh-autosuggestions zsh-syntax-highlighting)" ~/.zshrc; then
        sed -i.bak '/^source $ZSH\/oh-my-zsh.sh/i \
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)' ~/.zshrc
    fi

    # Ensure the main shell scripts are sourced only once
    if ! grep -q "source ~/.fpd-shell/fpd-shell.sh" ~/.zshrc; then
        echo 'source ~/.fpd-shell/fpd-shell.sh' >> ~/.zshrc
    fi
    if ! grep -q "source ~/.fpd-shell/.fpd-shellrc" ~/.zshrc; then
        echo 'source ~/.fpd-shell/.fpd-shellrc' >> ~/.zshrc
    fi

    # Ensure oh-my-zsh is sourced only once
    if ! grep -q "source \$ZSH/oh-my-zsh.sh" ~/.zshrc; then
        echo 'source $ZSH/oh-my-zsh.sh' >> ~/.zshrc
    fi

    echo "Theme set to $ZSH_THEME and plugins configured."
}
