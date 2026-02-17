return {
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
    ft = { "rust" },
    config = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(client, bufnr)
            local opts = { buffer = bufnr, remap = false }

            -- Standard LSP keymaps
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
            vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

            -- Rust-specific keymaps
            vim.keymap.set("n", "<leader>re", function()
              vim.cmd.RustLsp("explainError")
            end, { buffer = bufnr, desc = "Rust: Explain Error" })

            vim.keymap.set("n", "<leader>rc", function()
              vim.cmd.RustLsp("openCargo")
            end, { buffer = bufnr, desc = "Rust: Open Cargo.toml" })

            vim.keymap.set("n", "<leader>rr", function()
              vim.cmd.RustLsp("runnables")
            end, { buffer = bufnr, desc = "Rust: Runnables" })

            vim.keymap.set("n", "<leader>rd", function()
              vim.cmd.RustLsp("debuggables")
            end, { buffer = bufnr, desc = "Rust: Debuggables" })

            vim.keymap.set("n", "<leader>rt", function()
              vim.cmd.RustLsp("testables")
            end, { buffer = bufnr, desc = "Rust: Testables" })

            vim.keymap.set("n", "<leader>rm", function()
              vim.cmd.RustLsp("expandMacro")
            end, { buffer = bufnr, desc = "Rust: Expand Macro" })

            vim.keymap.set("n", "<leader>rp", function()
              vim.cmd.RustLsp("parentModule")
            end, { buffer = bufnr, desc = "Rust: Parent Module" })

            vim.keymap.set("n", "<leader>rj", function()
              vim.cmd.RustLsp("joinLines")
            end, { buffer = bufnr, desc = "Rust: Join Lines" })
          end,
          default_settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
              },
              check = {
                command = "clippy",
              },
              procMacro = {
                enable = true,
              },
            },
          },
        },
      }
    end,
  },

  -- Crates.nvim for Cargo.toml dependency management
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    config = function()
      require("crates").setup({
        completion = {
          cmp = {
            enabled = true,
          },
        },
      })
    end,
  },
}
