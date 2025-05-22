# 🏠 Dotfiles

Modern dotfiles management with **Chezmoi**, **Mise**, and **DevPod** support.

## ✨ Features

- 🔧 **Chezmoi**: Secure dotfiles management with templating support
- 📦 **Mise**: Automatic tool version management  
- 🐳 **DevPod**: Compatible with DevContainer specification for reproducible environments
- 🚀 **One-command setup**: Get up and running instantly
- 🔄 **Cross-platform**: Works on physical machines and development containers

## 🛠️ Tools Managed

- **Shell**: Fish, Nushell
- **Editor**: Neovim (LazyVim), Vim
- **Terminal**: Ghostty, WezTerm, Tmux
- **CLI Tools**: Bat, Ripgrep, Lazygit, Starship, FD, and more
- **Development**: Node.js, 1Password CLI

## 🚀 Quick Setup

### With DevPod (Recommended)

```bash
devpod up . --ide none --dotfiles git@github.com:MozkaGit/dotfiles.git
```

### Without DevPod

```bash
git clone https://github.com/MozkaGit/dotfiles.git
cd dotfiles
./setup
```

## 🏗️ Architecture

```
dotfiles/
├── .chezmoiexternals/      # External dependencies (mise, neovim, tmux)
├── .chezmoiscripts/        # Automated setup scripts
├── .chezmoiignore.tmpl     # Conditional file exclusions
├── dot_config/             # XDG config directory (~/.config/)
│   ├── fish/               # Fish shell configuration
│   ├── nvim/               # Neovim configuration
│   ├── tmux/               # Tmux configuration
│   ├── mise/               # Tool version management
│   └── ...
├── dot_vimrc               # Vim configuration
├── dot_wezterm.lua         # WezTerm configuration
└── setup                   # Bootstrap script
```

## 🎯 DevPod Integration

This setup is optimized for DevPod workflows:

- **Automatic detection**: DevPod automatically finds and executes the `setup` script
- **Environment-aware**: GUI applications (Ghostty, Solaar, WezTerm) are excluded in container environments
- **Consistent experience**: Same configuration works across local machines and dev containers

## 🔧 Customization

- **Add global tools**: Edit `dot_config/mise/config.toml` (for system-wide tools like ripgrep, bat, etc.)
- **Modify configurations**: Configuration files are managed by Chezmoi templates
- **Environment-specific settings**: Use `.chezmoiignore.tmpl` for conditional exclusions

## 📖 Documentation

- [DevPod Documentation](https://devpod.sh/)
- [Chezmoi Documentation](https://chezmoi.io/)
- [Mise Documentation](https://mise.jdx.dev/)

---

> **Note**: This replaces the previous Stow-based configuration with a modern approach optimized for reproducible development environments.
