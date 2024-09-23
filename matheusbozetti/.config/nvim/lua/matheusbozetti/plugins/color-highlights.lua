return {
  'uga-rosa/ccc.nvim',
  config = function()
    require('ccc').setup({
      highlighter = {
        auto_enable = true,
        lsp = true,
        treesitter = true,
        -- virtual_text = true, -- TODO: check if it works, change to false in favor of lsp_lines
        virtual_text = false,
      },
    })
  end,
}
