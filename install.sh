#!/bin/bash

# Function to install Oh My Zsh
install_oh_my_zsh() {
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  
  # Install zsh-autosuggestions and zsh-syntax-highlighting plugins
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
}

# Function to set the Oh My Zsh theme and plugins
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
    echo "source \$ZSH/oh-my-zsh.sh" >> ~/.zshrc
  fi

  echo "Theme set to $ZSH_THEME and plugins configured."
}

# Function to uninstall FPD Shell and Oh My Zsh
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

# Function to print success message
print_success_message() {
  echo "FPD Shell installed successfully!"
}

# Prompt user for installation or uninstallation
read -p "Do you want to install or uninstall FPD Shell? (install/uninstall): " action

case $action in
  install)
    read -p "Do you want to install Oh My Zsh? (y/n): " install_omz
    if [ "$install_omz" == "y" ]; then
      install_oh_my_zsh
      set_oh_my_zsh_theme_and_plugins
      echo 'print_success_message' >> ~/.zshrc
    else
      print_success_message
    fi

    # Clone the repository
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
    ;;
  uninstall)
    uninstall_fpd_shell
    ;;
  *)
    echo "Invalid option. Please choose 'install' or 'uninstall'."
    ;;
esac
