# Neovim Configuration

My personal Neovim configuration for **Python** and **Rust** development.

**Theme**: [Rosé Pine](https://rosepinetheme.com/)  
**Plugin Manager**: [lazy.nvim](https://github.com/folke/lazy.nvim)

## Features

- **Python**: Pyright (type checking) + Ruff (linting & formatting) + venv selector + format-on-save
- **Rust**: [rustaceanvim](https://github.com/mrcjkb/rustaceanvim) with rust-analyzer, clippy, and [crates.nvim](https://github.com/saecki/crates.nvim) for Cargo.toml
- **Treesitter**: Syntax highlighting, indentation, and code folding for Python, Rust, Lua, C, Go, JS, HTML, and more
- **Autocompletion**: nvim-cmp with LSP, buffer, path, and snippet sources (LuaSnip)
- **Fuzzy Finder**: Telescope (files, git files, grep, help tags)
- **File Explorer**: Neo-tree
- **Terminal**: Toggleterm (floating, horizontal, vertical terminals)
- **Auto-save**: Enabled by default

## Requirements

- **Neovim >= 0.11** (uses native `vim.lsp.config` API)
- **Git**
- **A C compiler** (`cc`, `gcc`, or `clang`) — for treesitter parser compilation
- **Node.js** — for pyright installation
- [Nerd Font](https://www.nerdfonts.com/) *(optional, for icons in neo-tree and statusline)*

## Installation

### Step 1: Install Neovim

```bash
# macOS
brew install neovim

# Ubuntu/Debian
# See https://github.com/neovim/neovim/releases for latest .deb or AppImage
```

Make sure you have **Neovim >= 0.11**:

```bash
nvim --version
```

### Step 2: Install External Dependencies

These tools must be available on your `$PATH` for LSP, linting, and formatting to work.

#### Python Tooling

```bash
# Pyright (Python type checker / LSP)
npm install -g pyright

# Ruff (Python linter & formatter)
# macOS
brew install ruff
# or with pip (if not on Homebrew-managed Python)
pip install ruff
```

#### Rust Tooling

```bash
# Install Rust via rustup (includes cargo, rustc, and rust-analyzer)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Ensure rust-analyzer is installed
rustup component add rust-analyzer
```

#### Other Dependencies

```bash
# fd (fast file finder, required by venv-selector)
# macOS
brew install fd
# Ubuntu/Debian
sudo apt install fd-find

# ripgrep (used by Telescope for live grep)
# macOS
brew install ripgrep
# Ubuntu/Debian
sudo apt install ripgrep
```

### Step 3: Clone the Configuration

> **⚠️ Backup your existing config first!**
> ```bash
> mv ~/.config/nvim ~/.config/nvim.bak
> mv ~/.local/share/nvim ~/.local/share/nvim.bak
> ```

```bash
git clone https://github.com/vinaaaaay/nvim-config.git ~/.config/nvim
```

### Step 4: Launch Neovim

```bash
nvim
```

On first launch, **lazy.nvim** will automatically:
1. Bootstrap itself
2. Install all plugins
3. Compile treesitter parsers

Wait for the installation to finish (you'll see a Lazy UI pop up), then **restart Neovim**.

### Step 5: Verify Everything Works

Open a Python file and check that LSP is active:

```bash
nvim test.py
```

Inside Neovim, run:
```
:lua print(vim.inspect(vim.tbl_map(function(c) return c.name end, vim.lsp.get_clients())))
```

You should see `{ "pyright", "ruff" }`. For a Rust project, open a `.rs` file inside a Cargo project and `rust-analyzer` should attach automatically.

## Directory Structure

```
~/.config/nvim/
├── init.lua                    # Entry point: basic settings, keymaps, lazy.nvim bootstrap
├── lsp/                        # Native LSP server configurations (Neovim 0.11+)
│   ├── pyright.lua             # Pyright config (Python type checking)
│   └── ruff.lua                # Ruff config (Python linting)
├── lua/
│   └── plugins/                # Plugin specs loaded by lazy.nvim
│       ├── lsp.lua             # Autocompletion (nvim-cmp) + LSP keymaps + server enable
│       ├── python.lua          # conform.nvim (format-on-save) + venv-selector
│       ├── rust.lua            # rustaceanvim + crates.nvim
│       ├── treesitter.lua      # Treesitter config
│       ├── telescope.lua       # Fuzzy finder
│       ├── neo-tree.lua        # File explorer
│       ├── toggleterm.lua      # Terminal integration
│       ├── colorscheme.lua     # Rosé Pine theme
│       └── autosave.lua        # Auto-save on focus lost
└── lazy-lock.json              # Plugin version lock file
```

## Key Bindings

Leader key: **`Space`**

### LSP (all languages)

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` | Find references |
| `K` | Hover documentation |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename symbol |
| `<leader>vd` | Open diagnostic float |
| `[d` / `]d` | Previous / next diagnostic |
| `<C-h>` *(insert)* | Signature help |
| `<leader>f` | Format buffer |

### Rust-specific (`<leader>r`)

| Key | Action |
|-----|--------|
| `<leader>re` | Explain error |
| `<leader>rc` | Open Cargo.toml |
| `<leader>rr` | Runnables |
| `<leader>rd` | Debuggables |
| `<leader>rt` | Testables |
| `<leader>rm` | Expand macro |
| `<leader>rp` | Parent module |
| `<leader>rj` | Join lines |

### Python-specific

| Key | Action |
|-----|--------|
| `<leader>ps` | Select virtual environment |
| `<leader>cf` | Format buffer (conform/ruff) |

### Navigation & Search

| Key | Action |
|-----|--------|
| `<leader>pf` | Find files (Telescope) |
| `<C-p>` | Git files (Telescope) |
| `<leader>ps` | Grep search (Telescope) |
| `<leader>vh` | Help tags (Telescope) |
| `<leader>pv` | Open file explorer (netrw) |

### Editing

| Key | Action |
|-----|--------|
| `J` *(visual)* | Move selection down |
| `K` *(visual)* | Move selection up |
| `<leader>y` | Yank to system clipboard |
| `<leader>d` | Delete without yanking |
| `<leader>p` *(visual)* | Paste without overwriting register |

## Updating

To update all plugins to the latest versions:

```vim
:Lazy update
```

To sync plugins (install missing + update + clean unused):

```vim
:Lazy sync
```
