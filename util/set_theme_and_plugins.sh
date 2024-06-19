#!/bin/bash

set_oh_my_zsh_theme_and_plugins() {
    echo "Select a theme for Oh My Zsh or type your custom theme:"
    echo "1) robbyrussell"
    echo "2) agnoster"
    echo "3) gallois"
    echo "4) avit"
    echo "5) random"
    echo "6) Custom theme"
    read -p "Enter the number corresponding to your choice or type your theme name: " theme_choice
    
    case $theme_choice in
        1) ZSH_THEME="robbyrussell";;
        2) ZSH_THEME="agnoster";;
        3) ZSH_THEME="gallois";;
        4) ZSH_THEME="avit";;
        5) ZSH_THEME="random";;
        6)
            read -p "Enter your custom theme name: " custom_theme
            ZSH_THEME=$custom_theme
        ;;
        *)
            if [[ -n $theme_choice ]]; then
                ZSH_THEME=$theme_choice
            else
                echo "Invalid choice, defaulting to robbyrussell"
                ZSH_THEME="robbyrussell"
            fi
        ;;
    esac
    
    # Create .zshrc if it doesn't exist
    if [ ! -f ~/.zshrc ]; then
        touch ~/.zshrc
    fi
    
    # Set the theme and plugins in .zshrc
    if grep -q "^ZSH_THEME=" ~/.zshrc; then
        sed -i.bak "s/^ZSH_THEME=.*/ZSH_THEME=\"$ZSH_THEME\"/" ~/.zshrc
    else
        echo "ZSH_THEME=\"$ZSH_THEME\"" >> ~/.zshrc
    fi
    
    if grep -q "^plugins=" ~/.zshrc; then
        sed -i.bak "s/^plugins=.*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/" ~/.zshrc
    else
        echo "plugins=(git zsh-autosuggestions zsh-syntax-highlighting)" >> ~/.zshrc
    fi
    
    # Add source for oh-my-zsh if not already present
    if ! grep -q "source \$ZSH/oh-my-zsh.sh" ~/.zshrc; then
        echo "ZSH=\$HOME/.oh-my-zsh" >> ~/.zshrc
        echo "source \$ZSH/oh-my-zsh.sh" >> ~/.zshrc
    fi
    
    echo "Theme set to $ZSH_THEME and plugins configured."
}
