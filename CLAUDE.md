# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration using a hybrid vimscript + Lua architecture. The configuration emphasizes modern development workflows with extensive AI integration, particularly with Claude Code.

## Architecture

### File Structure
- `init.vim` - Main vimscript entry point
- `lua/` - Lua configuration modules:
  - `basic.lua` - Core Neovim settings
  - `keybinding.lua` - Global key mappings (leader key: space)
  - `theme.lua` - Color scheme configuration
  - `register.lua` - Custom user commands
  - `plugin-config/` - Individual plugin configurations

### Plugin Management
Uses **vim-plug** with automatic installation. Plugin versions are tracked in `plugin-snapshot.vim` for reproducibility.

### Key Development Integrations
- **LSP**: coc.nvim with coc-go for Go development
- **AI Assistance**: claudecode.nvim (primary), supermaven-nvim (alternative)
- **Completion**: nvim-cmp with GitHub Copilot
- **Debugging**: vimspector with delve/debugpy support
- **Git**: Complete integration with gitsigns, fugitive, diffview

## Common Commands

### Plugin Management
```vim
:PlugInstall     # Install plugins
:PlugUpdate      # Update plugins
```

### Essential Development Workflows
- `<leader>ff` or `<C-p>`: Find files with Telescope
- `<leader>fg`: Live grep search
- `<leader>f`: Format current buffer
- `<leader>i`: Organize imports (Go/Python)
- `gd`: Go to definition
- `gy`: Go to type definition
- `gr`: Find references
- `<leader>dd`: Start debugging (vimspector)

### AI Assistant Integration
- `<leader>a`: Claude Code main command
- `<leader>af`: Focus Claude Code
- `<leader>ar`: Resume Claude Code session
- `<leader>aa`: Accept diff changes
- `<leader>ad`: Deny diff changes
- `<leader>as`: Send selection to Claude

### File & Window Management
- `<leader>fk`: Toggle file tree (nvim-tree)
- `<leader>fj`: Focus file tree
- `<leader>h/j/k/l`: Window navigation
- `sv/ss`: Vertical/horizontal split
- `sc/so`: Close current/other windows
- `<S-h>/<S-l>`: Buffer tab switching

### Session Management
- `<leader>qs`: Save session
- `<leader>qd`: Stop session persistence

## Setup Process

### Initial Installation
```bash
# Clone to config directory
git clone <repo> ~/.config/nvim

# Install plugins in Neovim
:nvim
:PlugInstall

# Run environment setup (optional)
./install.sh
```

### Environment Dependencies
Required tools: git, lazygit, fzf, python3, nodejs, fd-find, ripgrep

The `install.sh` script automates complete environment setup including system dependencies, development tools, font installation, and plugin management.

## Configuration Patterns

### Keybinding Conventions
- Leader-based shortcuts with mnemonic patterns
- Mode-specific mappings (normal, visual, insert, terminal)
- Plugin-specific integrations defined in `keybinding.lua`

### Lua Module Organization
Each plugin follows consistent pattern:
- Plugin-specific setup in `plugin-config/{plugin-name}.lua`
- Keybinding integration in `keybinding.lua`
- Loading sequence controlled from `init.vim`

### Performance Optimizations
- Reduced updatetime (300ms) for faster completion
- Smart search patterns (`/\v`) for better regex
- File filtering for build artifacts and node_modules
- Lazy loading for terminal and Git plugins