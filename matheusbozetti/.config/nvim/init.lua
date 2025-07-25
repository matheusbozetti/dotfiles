require('matheusbozetti')

-- [[ Install `lazy.nvim` plugin manager ]]

--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { import = 'matheusbozetti.plugins' },
})

-- Applies the colorscheme and transparency
-- lua/matheusbozetti/colors.lua
ColorMe('gruvbox-material')
