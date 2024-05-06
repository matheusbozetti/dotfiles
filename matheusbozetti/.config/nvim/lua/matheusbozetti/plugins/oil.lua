return {
  'stevearc/oil.nvim',
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local oil = require('oil')

    oil.setup({
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
      },
      float = {
        padding = 4,
      },
      preview = {
        max_width = 0.8,
        max_height = 0.8,
      },
    })

    vim.keymap.set('n', '-', '<CMD>Oil --float<CR>', { desc = 'Open parent directory' })
  end,
}
