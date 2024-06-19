#!/bin/bash

# Resolve the directory of the current script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Source utility functions
source "$SCRIPT_DIR/util/install_oh_my_zsh.sh"
source "$SCRIPT_DIR/util/set_theme_and_plugins.sh"
source "$SCRIPT_DIR/util/uninstall_fpd_shell.sh"
source "$SCRIPT_DIR/util/print_success_message.sh"

# Prompt user for installation or uninstallation
read -p "Do you want to install or uninstall FPD Shell? (i/u): " action

case $action in
    i|install)
        read -p "Do you want to install Oh My Zsh? (y/n): " install_omz
        if [ "$install_omz" == "y" ]; then
            if [ -d ~/.oh-my-zsh ]; then
                echo "The \$ZSH folder already exists ($HOME/.oh-my-zsh)."
                echo "You'll need to remove it if you want to reinstall."
            else
                install_oh_my_zsh
                set_oh_my_zsh_theme_and_plugins
                echo 'print_success_message' >> ~/.zshrc
            fi
        else
            print_success_message
        fi
        
        # Clone the repository
        if [ -d ~/.fpd-shell ]; then
            echo "~/.fpd-shell already exists. Please remove it or choose another directory."
        else
            echo "Cloning the FPD Shell repository..."
            git clone https://github.com/FlowPress/fpd-shell.git ~/.fpd-shell
            
            # Source the main shell script in .bashrc or .zshrc
            if [ -f ~/.zshrc ]; then
                echo 'source ~/.fpd-shell/fpd-shell.sh' >> ~/.zshrc
                source ~/.zshrc
                elif [ -f ~/.bashrc ]; then
                echo 'source ~/.fpd-shell/fpd-shell.sh' >> ~/.bashrc
                source ~/.bashrc
            else
                # Default to creating .bashrc if neither exists
                echo 'source ~/.fpd-shell/fpd-shell.sh' >> ~/.bashrc
                source ~/.bashrc
            fi
        fi
    ;;
    u|uninstall)
        uninstall_fpd_shell
    ;;
    *)
        echo "Invalid option. Please choose 'i' for install or 'u' for uninstall."
    ;;
esac
