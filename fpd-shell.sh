#!/bin/zsh

# FPD Shell Version
FPD_SHELL_VERSION="1.0.0"

# Function to display version
function show_version() {
    echo "FPD Shell version $FPD_SHELL_VERSION"
}

function show_help() {
    echo "FPD Shell Commands:"
    echo "Functions:"
    grep -oP 'function \K\w+' ~/.fpd-shell/.fpd-shellrc
    echo "Scripts:"
    ls ~/.fpd-shell/scripts
}


# Load all functions
source ~/.fpd-shell/.fpd-shellrc

# Load all scripts in the scripts directory
for script in ~/.fpd-shell/scripts/*.sh; do
    source $script
done

# Display version on terminal startup
show_version
