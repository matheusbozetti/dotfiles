local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
local lsp_format_on_save = function(bufnr)
  vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
end

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
      lsp_zero.preset('recommended')

      local function addDesc(desc, localOpts)
        return vim.tbl_extend('force', localOpts, { desc = desc })
      end

      vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<cr>', addDesc('Open [E]rror diagnostic', opts))

      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, addDesc('[C]ode [A]ction', opts))

      vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', addDesc('[G]oto [D]efinition', opts))
      vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', addDesc('[G]oto [D]eclaration', opts))
      vim.keymap.set('n', 'gI', '<cmd>lua vim.lsp.buf.implementation()<cr>', addDesc('[G]oto [I]mplementation', opts))
      vim.keymap.set(
        'n',
        'go',
        '<cmd>lua vim.lsp.buf.type_definition()<cr>',
        addDesc('[G]oto [O]ther [D]efinition', opts)
      )
      vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', addDesc('[G]oto [R]eferences', opts))

      vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', addDesc('[D]iagnostic [P]rev', opts))
      vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', addDesc('[D]iagnostic [N]ext', opts))

      lsp_zero.default_keymaps(opts)
      lsp_format_on_save(bufnr)
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
      'vue-language-server',
      'volar',
      'golangci-lint',
      'goimports',
      'gopls',
      'clangd',
      'clang-format',
      'cpplint',
    })

    require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

    local root_pattern = require('lspconfig.util').root_pattern
    local util = require('lspconfig.util')
    local root_dir = root_pattern('package.json', 'tsconfig.json', '.git')

    require('mason-lspconfig').setup({
      ensure_installed = {
        'volar',
      },
      handlers = {
        lsp_zero.default_setup,
        tsserver = function()
          local vue_typescript_plugin = require('mason-registry').get_package('vue-language-server'):get_install_path()
            .. '/node_modules/@vue/language-server'
            .. '/node_modules/@vue/typescript-plugin'

          require('lspconfig').tsserver.setup({
            root_dir = root_dir,
            init_options = {
              plugins = {
                {
                  name = '@vue/typescript-plugin',
                  location = vue_typescript_plugin,
                  languages = { 'javascript', 'typescript', 'vue' },
                },
              },
            },
            filetypes = {
              'javascript',
              'javascriptreact',
              'javascript.jsx',
              'typescript',
              'typescriptreact',
              'typescript.tsx',
              'vue',
            },
          })
        end,
        volar = function()
          require('lspconfig').volar.setup({})
        end,
      },
      opts = {
        auto_install = true,
      },
    })

    -- TODO: Move to another file and test it
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    luasnip.config.setup({})

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = { completeopt = 'menu,menuone,noinsert' },
      mapping = cmp.mapping.preset.insert({
        -- Select the [n]ext item
        ['<C-n>'] = cmp.mapping.select_next_item(),
        -- Select the [p]revious item
        ['<C-p>'] = cmp.mapping.select_prev_item(),

        -- Accept ([y]es) the completion.
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        --  completions whenever it has completion options available.
        ['<C-Space>'] = cmp.mapping.complete({}),
        ['<C-0>'] = cmp.mapping.complete({}),
        -- <c-l> will move you to the right of each of the expansion locations.
        -- <c-h> is similar, except moving you backwards.
        ['<C-l>'] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { 'i', 's' }),
      }),
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip', max_item_count = 5 },
        { name = 'buffer', max_item_count = 5 },
        { name = 'codeium.nvim', max_item_count = 5 },
        { name = 'path', max_item_count = 5 },
      },
      experimental = {
        ghost_text = false,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
    })
  end,
}
