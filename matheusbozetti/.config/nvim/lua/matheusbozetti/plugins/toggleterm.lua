return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    local toggleterm = require('toggleterm')
    toggleterm.setup({
      direction = 'float',
    })

    vim.keymap.set({ 'n', 't' }, '<M-t>', function()
      toggleterm.toggle()
    end, {
      desc = '[T]erminal [T]oggle',
    })
  end,
}
