return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup({
      integrations = {
        cmp = true,
        gitsigns = true,
        harpoon = true,
        mason = true,
        telescope = true,
        nvimtree = true,
      },
    })
  end,
}
