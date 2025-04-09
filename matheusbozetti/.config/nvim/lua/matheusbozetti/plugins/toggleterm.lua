return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    local toggleterm = require('toggleterm')
    toggleterm.setup({
      direction = 'horizontal',
    })

    vim.keymap.set({ 'n', 't' }, '<C-`>', function()
      toggleterm.toggle()
    end, {
      desc = '[T]erminal [T]oggle',
    })
  end,
}
