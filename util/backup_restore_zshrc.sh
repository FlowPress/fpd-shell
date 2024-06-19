#!/bin/bash

# Backup .zshrc if it doesn't already exist
backup_zshrc() {
	if [[ -f ~/.zshrc && ! -f ~/.zshrc.fpd.backup ]]; then
		cp ~/.zshrc ~/.zshrc.fpd.backup
		echo "Backup of .zshrc created as .zshrc.fpd.backup"
	fi
}

# Restore .zshrc from backup
restore_zshrc() {
	if [[ -f ~/.zshrc.fpd.backup ]]; then
		cp ~/.zshrc.fpd.backup ~/.zshrc
		echo "Restored .zshrc from .zshrc.fpd.backup"
	fi
}
