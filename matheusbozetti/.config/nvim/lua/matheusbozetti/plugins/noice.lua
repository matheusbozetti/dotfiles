return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
  config = function()
    local routes = {
      {
        filter = {
          event = 'notify',
          find = 'No information available',
        },
        opts = { skip = true },
      },
    }

    require('notify').setup({
      background_colour = '#000000',
    })

    require('noice').setup({
      routes = routes,
      presets = {
        lsp_doc_border = true,
      },
    })
  end,
}
