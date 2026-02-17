return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require("toggleterm").setup({
      -- Size of terminal
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      
      -- Terminal settings
      open_mapping = [[<c-\>]], -- Ctrl+\ to toggle main terminal
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      persist_mode = true,
      direction = 'horizontal', -- 'vertical' | 'horizontal' | 'tab' | 'float'
      close_on_exit = true,
      shell = vim.o.shell,
      
      -- Floating terminal settings
      float_opts = {
        border = 'curved', -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
        width = 120,
        height = 30,
        winblend = 3,
      }
    })

    -- Custom keymaps
    local opts = {noremap = true, silent = true}
    
    -- Toggle terminals
    vim.keymap.set('n', '<leader>th', ':ToggleTerm direction=horizontal<CR>', opts)
    vim.keymap.set('n', '<leader>tv', ':ToggleTerm direction=vertical<CR>', opts)
    vim.keymap.set('n', '<leader>tf', ':ToggleTerm direction=float<CR>', opts)
    vim.keymap.set('n', '<leader>tt', ':ToggleTerm direction=tab<CR>', opts)
    
    -- Terminal numbers (multiple terminals)
    vim.keymap.set('n', '<leader>1', ':1ToggleTerm<CR>', opts)
    vim.keymap.set('n', '<leader>2', ':2ToggleTerm<CR>', opts)
    vim.keymap.set('n', '<leader>3', ':3ToggleTerm<CR>', opts)
    vim.keymap.set('n', '<leader>4', ':4ToggleTerm<CR>', opts)
    
    -- Terminal mode mappings (when you're inside the terminal)
    function _G.set_terminal_keymaps()
      local opts = {buffer = 0}
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
    end

    -- Apply terminal keymaps when terminal opens
    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

    -- Custom terminal commands for common tools
    local Terminal = require('toggleterm.terminal').Terminal
    
    -- Lazygit terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",
      float_opts = {
        border = "double",
      },
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
      end,
      on_close = function(term)
        vim.cmd("startinsert!")
      end,
    })

    function _lazygit_toggle()
      lazygit:toggle()
    end

    vim.keymap.set("n", "<leader>lg", "<cmd>lua _lazygit_toggle()<CR>", opts)
    
    -- HTOP terminal
    local htop = Terminal:new({
      cmd = "htop",
      direction = "float",
      float_opts = {
        border = "double",
      }
    })

    function _htop_toggle()
      htop:toggle()
    end

    vim.keymap.set("n", "<leader>ht", "<cmd>lua _htop_toggle()<CR>", opts)
  end,
}
