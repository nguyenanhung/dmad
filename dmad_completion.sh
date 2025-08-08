#!/bin/bash

_dmad_completion() {
  local cur prev opts
  COMPREPLY=()                         # Array to store completion suggestions
  cur="${COMP_WORDS[COMP_CWORD]}"      # Current word being typed by the user
  prev="${COMP_WORDS[COMP_CWORD - 1]}" # Previous word in the command

  # Define available options as an array for easy extension
  opts=(
    "install"                      # Installation-related commands
    "basic-auth"                   # Basic authentication commands
    "reload-caddy"                 # Caddy reload commands
    "log"                          # Logging commands
    "down"                         # Docker compose down command
    "up"                           # Docker compose up command
    "up-with-caddy"                # Docker compose up with Caddy command
    "up-without-caddy"             # Docker compose up without Caddy command
    "status"                       # Docker status command
    "self-update"                  # Self-update command
    "setup-completion"             # Setup completion command
    "pihole-subscribe-list"        # Update pihole subscribe list command
    "pihole-setpassword"           # Update pihole password command
    "pihole-pull"                  # Pull latest pihole image
    "pihole-update"                # Update latest pihole image
    "update-pihole"                # Update latest pihole image
    "update-pihole"                # Update latest pihole image
    "update-wg-easy"               # Update latest wg-easy image
    "update-unbound"               # Update latest unbound image
    "join-caddy-network"           # Join Caddy network command
    "enable-domain-external-caddy" # Enable domain external Caddy command
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
complete -F _dmad_completion ./dmad/dmad
