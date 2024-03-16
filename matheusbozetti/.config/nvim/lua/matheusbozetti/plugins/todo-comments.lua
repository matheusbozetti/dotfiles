return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('todo-comments').setup({
      signs = false,
    })

    vim.keymap.set('n', ']t', function()
      require('todo-comments').jump_next()
    end, { desc = 'Next todo comment' })

    vim.keymap.set('n', '[t', function()
      require('todo-comments').jump_prev()
    end, { desc = 'Previous todo comment' })

    vim.keymap.set('n', '<leader>ptt', '<cmd>:TodoTelescope<CR>', { desc = '[T]odo comments [T]elescope' })
    vim.keymap.set('n', '<leader>ptl', '<cmd>:TodoLocList<CR>', { desc = '[T]odo coments [L]ocList' })
  end,
}
