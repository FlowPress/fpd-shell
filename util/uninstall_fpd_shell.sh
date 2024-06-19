#!/bin/bash

uninstall_fpd_shell() {
    echo "Uninstalling FPD Shell and Oh My Zsh..."
    
    # Remove FPD Shell source line from .bashrc and .zshrc
    sed -i.bak '/source ~\/.fpd-shell\/fpd-shell.sh/d' ~/.bashrc
    sed -i.bak '/source ~\/.fpd-shell\/fpd-shell.sh/d' ~/.zshrc
    
    # Remove FPD Shell directory
    rm -rf ~/.fpd-shell
    
    # Remove Oh My Zsh if installed
    if [ -d ~/.oh-my-zsh ]; then
        rm -rf ~/.oh-my-zsh
        mv ~/.zshrc.bak ~/.zshrc  # Restore the original .zshrc backup if available
    fi
    
    echo "FPD Shell and Oh My Zsh uninstalled successfully!"
}
