local default_installed = {
  -- lua
  'stylua',
  'lua-language-server',
  -- json
  'jsonlint',
  -- javascript & typescript
  'eslint',
  'prettier',
  'biome',
  'typescript-language-server',
  'vue-language-server',
  'volar',
  -- c & c++
  'clangd',
  'clang-format',
  'cpplint',
  -- golang
  'gopls',
  'gofumpt',
  'golines',
  'golangci-lint',
  'goimports',
  -- rust
  'rust-analyzer',
  --odin
  'ols',
  --zig
  'zls',
}

local function hasBiome(path)
  local util = require('lspconfig.util')
  local rootPath = util.root_pattern('biome.json', 'biome.jsonc')(path)

  if rootPath == nil then
    return false
  end

  return true
end

local navicAttach = function(navic, client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
end

return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v4.x',
  dependencies = {
    -- LSP Support
    { 'neovim/nvim-lspconfig' }, -- Required
    { 'lukas-reineke/lsp-format.nvim' }, -- Required
    { 'williamboman/mason.nvim' }, -- Optional
    { 'williamboman/mason-lspconfig.nvim' }, -- Optional
    { 'WhoIsSethDaniel/mason-tool-installer.nvim' },

    -- Autocompletion
    { 'hrsh7th/nvim-cmp' }, -- Required
    { 'hrsh7th/cmp-nvim-lsp' }, -- Required
    { 'L3MON4D3/LuaSnip' }, -- Required
  },
  config = function()
    vim.opt.signcolumn = 'yes'

    local lsp_zero = require('lsp-zero')

    local lspconfig_defaults = require('lspconfig').util.default_config
    lspconfig_defaults.capabilities =
      vim.tbl_deep_extend('force', lspconfig_defaults.capabilities, require('cmp_nvim_lsp').default_capabilities())

    vim.api.nvim_create_autocmd('LspAttach', {
      desc = 'LSP actions',
      callback = function(event)
        local opts = { buffer = event.buf }

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
      end,
    })

    lsp_zero.format_on_save({
      format_opts = {
        async = false,
        stop_after_first = true,
        timeout_ms = 10000,
      },
    })

    lsp_zero.set_sign_icons({
      error = '✘',
      warn = '▲',
      hint = '⚑',
      info = '»',
    })

    require('mason').setup({
      ui = {
        icons = {
          package_installed = '✓',
          package_uninstalled = '✗',
          package_pending = '⟳',
        },
      },
    })

    local servers = {
      lua_ls = {},
    }

    local ensure_installed = vim.tbl_keys(servers or {})

    vim.list_extend(ensure_installed, default_installed)

    require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

    local root_pattern = require('lspconfig.util').root_pattern
    local root_dir = root_pattern('package.json', 'tsconfig.json', '.git')

    local navic = require('nvim-navic')

    require('mason-lspconfig').setup({
      ensure_installed = {
        'volar',
      },
      handlers = {
        lsp_zero.default_setup,
        function(server_name)
          require('lspconfig')[server_name].setup({
            on_attach = function(client, bufnr)
              navicAttach(navic, client, bufnr)
            end,
          })
        end,
        ts_ls = function()
          local vue_typescript_plugin = require('mason-registry').get_package('vue-language-server'):get_install_path()
            .. '/node_modules/@vue/language-server'
            .. '/node_modules/@vue/typescript-plugin'

          require('lspconfig').ts_ls.setup({
            root_dir = root_dir,
            init_options = {
              plugins = {
                {
                  name = '@vue/typescript-plugin',
                  location = vue_typescript_plugin,
                  languages = { 'vue' },
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
              'svelte',
            },
            on_attach = function(client, bufnr)
              navicAttach(navic, client, bufnr)
            end,
          })
        end,
        volar = function()
          require('lspconfig').volar.setup({})
        end,
        eslint = function()
          if hasBiome(vim.fn.getcwd()) == true then
            return
          end

          require('lspconfig').eslint.setup({
            on_attach = function(client, bufnr)
              navicAttach(navic, client, bufnr)
            end,
          })
        end,
        biome = function()
          if hasBiome(vim.fn.getcwd()) == false then
            return
          end
          local util = require('lspconfig.util')

          require('lspconfig').biome.setup({
            default_config = {
              cmd = { 'biome', 'lsp-proxy', 'check', '--apply' },
              filetypes = {
                'javascript',
                'javascriptreact',
                'json',
                'jsonc',
                'typescript',
                'typescript.tsx',
                'typescriptreact',
                'astro',
                'svelte',
                'vue',
              },
              root_dir = util.root_pattern('biome.json', 'biome.jsonc'),
              single_file_support = false,
            },
            format_on_save = true,
            on_attach = function(client, bufnr)
              navicAttach(navic, client, bufnr)
            end,
          })
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
      completion = {
        completeopt = 'menu,menuone,noinsert',
      },
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
        { name = 'buffer', max_item_count = 5 },
        { name = 'luasnip', max_item_count = 5 },
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

    -- Add Signs to LSP Info
    local signs = { Error = '', Warn = '', Hint = '󰌵', Info = '󰋼' }
    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
  end,
}
