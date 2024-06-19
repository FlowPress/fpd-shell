#!/bin/bash

# Autocompletion function
_fpd_shell_autocomplete() {
  local cur opts
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  opts="$(grep -oP 'function \K\w+' ~/.fpd-shell/.fpd-shellrc)"

  COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
  return 0
}

complete -F _fpd_shell_autocomplete fpd-shell
