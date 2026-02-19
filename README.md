# Neovim Configuration

My personal Neovim configuration, primarily set up for **Rust development**(mostly).

## Features

- **Plugin Manager**: [lazy.nvim](https://github.com/folke/lazy.nvim)
- **Rust Support**: [rustaceanvim](https://github.com/mrcjkb/rustaceanvim) with rust-analyzer, clippy integration, and Cargo.toml management via [crates.nvim](https://github.com/saecki/crates.nvim)
- **File Explorer**: neo-tree
- **Fuzzy Finder**: Telescope
- **Syntax Highlighting**: Treesitter
- **LSP**: Built-in LSP with code actions, diagnostics, and formatting
- **Terminal**: toggleterm
- **Auto-save**: Enabled

## Installation
(Make sure to backup any existing nvim-config)

```bash
git clone https://github.com/vinaaaaay/nvim-config.git ~/.config/nvim
```

Open Neovim and plugins will install automatically.

## Requirements

- Neovim >= 0.9
- [rust-analyzer](https://rust-analyzer.github.io/) for Rust LSP
- A [Nerd Font](https://www.nerdfonts.com/) (optional, for icons)

## Key Bindings

Leader key: `Space`

### Rust-specific (`<leader>r`)

| Key | Action |
|-----|--------|
| `<leader>re` | Explain error |
| `<leader>rc` | Open Cargo.toml |
| `<leader>rr` | Run |
| `<leader>rd` | Debug |
| `<leader>rt` | Test |
| `<leader>rm` | Expand macro |

### General

| Key | Action |
|-----|--------|
| `<leader>f` | Format |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename |
| `gd` | Go to definition |
| `gr` | Find references |
| `K` | Hover docs |
