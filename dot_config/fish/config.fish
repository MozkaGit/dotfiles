if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Set LANG environment variable
set -gx LANG en_US.UTF-8

# Activate mise if installed
if command -q mise
    mise activate fish | source
    set -gx MISE_GITHUB_TOKEN "{{ onepasswordRead "op://DevOps/hjjxlhehpsy6zt77dmk5dfkmbm/token" }}"
end

# Initialize starship prompt if installed
if command -q starship
    starship init fish | source

    # Enable transience for cleaner command line history
    # (only if starship is available)
    enable_transience
end

# Load 1Password CLI completion if installed
if command -q op
    op completion fish | source

    # Source 1Password plugins if the file exists
    if test -f ~/.config/op/plugins.sh
        source ~/.config/op/plugins.sh
    end
end

# Initialize asdf version manager if installed
if test -d ~/.asdf
    source ~/.asdf/asdf.fish
end

# Set the default system editor to nvim if installed
if command -q nvim
    set -gx EDITOR nvim
end

# Set TERM environment variable for Ghostty
set -gx TERM xterm-256color

# Set 1Password ssh agent if the socket exists
if test -e ~/.1password/agent.sock
    set -gx SSH_AUTH_SOCK "~/.1password/agent.sock"
end

# Add persistent fix for DevPod's broken SSH signature wrapper (GitHub issue #1803)
# DevPod re-adds gpg.ssh.program after setup, so remove it on every shell startup
if env | grep -q -i devpod
  git config --global gpg.ssh.program ssh-keygen
end
