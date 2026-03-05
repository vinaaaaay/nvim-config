return {
  -- Format on save with ruff
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        desc = "Format buffer (conform)",
      },
    },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { "ruff_organize_imports", "ruff_format" },
        },
        format_on_save = {
          timeout_ms = 3000,
          lsp_format = "fallback",
        },
      })
    end,
  },

  -- Virtual environment selector (useful for AI/ML projects with different envs)
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    ft = "python",
    keys = {
      { "<leader>ps", "<cmd>VenvSelect<cr>", desc = "Python: Select Venv" },
    },
    config = function()
      require("venv-selector").setup()
    end,
  },
}
