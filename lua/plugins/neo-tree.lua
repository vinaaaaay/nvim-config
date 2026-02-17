return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = false,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      window = {
        position = "left",
        width = 30,
        mappings = {
          ["<space>"] = "none", -- disable space in neo-tree to avoid conflicts
          ["<tab>"] = "toggle_preview", -- Tab to preview files
          ["P"] = { "toggle_preview", config = { use_float = false } },
          ["l"] = "open",
          ["h"] = "close_node",
          ["z"] = "close_all_nodes",
          ["Z"] = "expand_all_nodes",
          ["a"] = {
            "add",
            config = {
              show_path = "none" -- "none", "relative", "absolute"
            }
          },
        },
      },
      filesystem = {
        follow_current_file = {
          enabled = true,
        },
        use_libuv_file_watcher = true,
      },
      default_component_configs = {
        file_size = {
          enabled = true,
          required_width = 64,
        },
        last_modified = {
          enabled = true,
          required_width = 88,
        },
      },
    })
    
    -- Toggle and navigation keybindings
    vim.keymap.set('n', '<leader>e', ':Neotree toggle filesystem left<CR>', {desc = "Toggle file explorer"})
    vim.keymap.set('n', '<leader>bf', ':Neotree toggle buffers float<CR>', {desc = "Toggle buffer explorer"})
    vim.keymap.set('n', '<leader>gs', ':Neotree toggle git_status float<CR>', {desc = "Toggle git status"})
    
    -- Focus/unfocus sidebar
    vim.keymap.set('n', '<leader>o', ':Neotree focus<CR>', {desc = "Focus file explorer"})
    vim.keymap.set('n', '<leader>c', ':Neotree close<CR>', {desc = "Close file explorer"})
  end
}
