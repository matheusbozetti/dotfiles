return {
  'sindrets/diffview.nvim',
  config = function()
    local diffview = require('diffview')

    diffview.setup({})

    vim.keymap.set(
      'n',
      '<leader>gh',
      '<cmd>DiffviewFileHistory %<CR>',
      { desc = '[G]it [H]istory for the current file' }
    )
  end,
}
