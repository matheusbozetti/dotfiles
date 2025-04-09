return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        'bash',
        'javascript',
        'typescript',
        'odin',
        'c',
        'css',
        'scss',
        'html',
        'vue',
        'lua',
        'markdown',
        'vim',
        'vimdoc',
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
