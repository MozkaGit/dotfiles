if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Initialize starship prompt for a customized shell appearance
starship init fish | source

# Enable transience for cleaner command line history
enable_transience

# Load 1Password CLI completion for fish shell
op completion fish | source

# Source 1Password plugins for additional functionality
source /home/mozka/.config/op/plugins.sh

# Initialize asdf version manager for managing runtime versions
source ~/.asdf/asdf.fish

# Set the default system editor to nvim
set -gx EDITOR nvim

# Set TERM environment variable for Ghostty
set -gx TERM xterm-256color
