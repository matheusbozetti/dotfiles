return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    local toggleterm = require('toggleterm')
    toggleterm.setup({
      direction = 'horizontal',
    })

    vim.keymap.set({ 'n', 't' }, '<M-0>', function()
      toggleterm.toggle()
    end, {
      desc = '[T]erminal [T]oggle',
    })
  end,
}
