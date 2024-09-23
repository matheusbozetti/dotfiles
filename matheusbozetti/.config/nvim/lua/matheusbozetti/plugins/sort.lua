return {
  'sQVe/sort.nvim',
  config = function()
    require('sort').setup({
      -- Input configuration here.
      -- Refer to the configuration section below for options.
    })

    vim.keymap.set('v', '<leader>s', '<CMD>Sort<CR>', { desc = 'Sort selected lines', noremap = true, silent = true })
  end,
}
