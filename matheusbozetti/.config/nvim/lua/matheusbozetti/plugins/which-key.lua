return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  dependencies = { { 'echasnovski/mini.nvim', version = false } },
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    vim.o.timeout = true
    vim.o.timeoutlen = 500

    -- Document existing key chains
    require('which-key').add({
      { '<leader>c', group = '[C]ode' },
      { '<leader>w', group = '[W]orkspace' },
      { '<leader>t', group = '[T]erminal' },
    })
  end,
}
