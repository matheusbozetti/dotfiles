return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v3.x',
  dependencies = {
    -- LSP Support
    { 'neovim/nvim-lspconfig' }, -- Required
    { 'williamboman/mason.nvim' }, -- Optional
    { 'williamboman/mason-lspconfig.nvim' }, -- Optional
    { 'WhoIsSethDaniel/mason-tool-installer.nvim' },

    -- Autocompletion
    { 'hrsh7th/nvim-cmp' }, -- Required
    { 'hrsh7th/cmp-nvim-lsp' }, -- Required
    { 'L3MON4D3/LuaSnip' }, -- Required
  },
  config = function()
    local lsp_zero = require('lsp-zero')

    lsp_zero.on_attach(function(_, bufnr)
      local opts = { buffer = bufnr, remap = false }

      vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<cr>', opts, { desc = { 'Open diagnostics' } })

      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

      lsp_zero.default_keymaps(opts)
    end)

    require('mason').setup()

    local servers = {
      lua_ls = {},
    }

    local ensure_installed = vim.tbl_keys(servers or {})

    vim.list_extend(ensure_installed, {
      'stylua', -- Used to format lua code
      'lua-language-server',
      'eslint',
      'prettier',
      'typescript-language-server',
      'golangci-lint',
      'goimports',
    })

    require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

    local util = require('lspconfig/util')
    local root_dir = util.root_pattern('package.json', 'tsconfig.json', '.git') or vim.loop.cwd()

    require('mason-lspconfig').setup({
      ensure_installed = {},
      handlers = {
        lsp_zero.default_setup,
        tsserver = function()
          require('lspconfig').tsserver.setup({
            root_dir = root_dir,
            filetypes = { 'typescript', 'vue', 'javascript', 'typescriptreact', 'javascriptreact' },
          })
        end,
      },
      opts = {
        auto_install = true,
      },
    })
  end,
}
