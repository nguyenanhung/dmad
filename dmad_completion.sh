#!/bin/bash

_dmad_completion() {
  local cur prev opts
  COMPREPLY=()                         # Array to store completion suggestions
  cur="${COMP_WORDS[COMP_CWORD]}"      # Current word being typed by the user
  prev="${COMP_WORDS[COMP_CWORD - 1]}" # Previous word in the command

  # Define available options as an array for easy extension
  opts=(
    "install"          # Installation-related commands
    "basic-auth"       # Basic authentication commands
    "reload-caddy"     # Caddy reload commands
    "log"              # Logging commands
    "down"             # Docker compose down command
    "up"               # Docker compose up command
    "self-update"      # Self-update command
    "setup-completion" # Setup completion command
  )

  # Check if the previous word is '--log', '-log', or 'log'
  if [[ "$prev" == "--log" || "$prev" == "-log" || "$prev" == "log" ]]; then
    # Use mapfile to safely read container names into COMPREPLY
    mapfile -t COMPREPLY < <(docker ps --format '{{.Names}}' | grep -E '^caddy|^wg-easy|^unbound|^pihole')
  else
    # Use mapfile to safely read compgen output into COMPREPLY
    mapfile -t COMPREPLY < <(compgen -W "${opts[*]}" -- "${cur}")
  fi

  return 0
}

# Register the completion function for the './dmad' command
complete -F _dmad_completion ./dmad
