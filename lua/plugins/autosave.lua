-- File: lua/plugins/autosave.lua
return {
  "Pocco81/auto-save.nvim",
  config = function()
    local autosave = require("auto-save")

    autosave.setup({
      enabled = true,
      trigger_events = { "InsertLeave", "TextChanged" },
      debounce_delay = 135,
      conditions = {
        exists = true,
        modifiable = true,
      },
      -- Optional custom message
      callbacks = {
        after_saving = function()
          vim.notify("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
        end,
      },
    })

    -- Toggle autosave with <leader>sa
    vim.keymap.set("n", "<leader>sa", function()
      if vim.g.auto_save_state == nil then
        vim.g.auto_save_state = true
      end
      vim.g.auto_save_state = not vim.g.auto_save_state
      if vim.g.auto_save_state then
        autosave.enable()
        vim.notify("AutoSave enabled", vim.log.levels.INFO)
      else
        autosave.disable()
        vim.notify("AutoSave disabled", vim.log.levels.WARN)
      end
    end, { desc = "Toggle AutoSave" })
  end,
}

