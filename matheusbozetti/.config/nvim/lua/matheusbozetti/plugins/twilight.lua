return {
  'folke/twilight.nvim',
  config = function()
    require('twilight').setup({
      dimming = {
        alpha = 0.3,
      },
    })

    vim.keymap.set('n', '<leader>tt', '<cmd>:Twilight<CR>', { desc = '[T]oggle [T]wilight' })
  end,
}
