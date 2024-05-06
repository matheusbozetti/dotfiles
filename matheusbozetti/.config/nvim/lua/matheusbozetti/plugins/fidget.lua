return {
  'j-hui/fidget.nvim', -- Neovim notifications and LSP progress messages
  branch = 'legacy',
  enabled = false,
  config = function()
    require('fidget').setup({
      window = { blend = 0 },
    })
  end,
}
