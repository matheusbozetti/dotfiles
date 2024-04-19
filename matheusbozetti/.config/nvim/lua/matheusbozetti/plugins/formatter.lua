local function biomeOrPrettier(bufnr)
  local has_biome_lsp = vim.lsp.get_active_clients({
    bufnr = bufnr,
    name = 'biome',
  })[1]
  if has_biome_lsp then
    return { 'biome' }
  end

  return { { 'prettierd', 'prettier' } }
end
return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufWritePre', 'BufNewFile' },
  cmd = { 'ConformInfo' },
  config = function()
    local conform = require('conform')
    local util = require('conform.util')

    local formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'isort', 'black' },
      c = { 'clang-format' },
      cpp = { 'clang-format' },
      objc = { 'clang-format' },
      objcpp = { 'clang-format' },
      go = { 'goimports', 'gofumpt', 'golines' },
      json = { 'jsonlint' },
      jsonc = { 'jsonlint' },
      javascript = biomeOrPrettier,
      javascriptreact = biomeOrPrettier,
      typescript = biomeOrPrettier,
      typescriptreact = biomeOrPrettier,
      vue = biomeOrPrettier,
    }

    local format_on_save = {
      lsp_fallback = true,
      async = false,
    }

    conform.formatters.clang_format = {
      exe = 'clang-format',
      args = { '--style=file' },
      stdin = true,
      cwd = vim.fn.getcwd(),
    }

    conform.formatters.prettier = {
      cwd = util.root_file({ '.prettierrc', '.prettierrc.js', '.prettierrc.json' }),
      require_cwd = true,
    }

    conform.formatters.prettierd = {
      cwd = util.root_file({ '.prettierrc', '.prettierrc.js', '.prettierrc.json' }),
      require_cwd = true,
    }

    conform.formatters.biome = {
      cwd = util.root_file({ 'biome.json', 'biome.jsonc' }),
      format_on_save = true,
      require_cwd = true,
    }

    conform.setup({
      log_level = vim.log.levels.DEBUG,
      formatters_by_ft = formatters_by_ft,
      format_on_save = format_on_save,
      on_attach = function(client, bufnr)
        if client.supported_methods('textDocument/formatting') then
          -- local has_biome_lsp = vim.lsp.get_active_clients({
          --   bufnr = bufnr,
          --   name = 'biome',
          -- })[1]
          -- if has_biome_lsp then
          --   print('has lsp')
          --   return {}
          -- end

          vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
            buffer = bufnr,
            pattern = '*',
            callback = function()
              conform.format({
                lsp_fallback = true,
                async = false,
              })
            end,
          })

          vim.keymap.set({ 'n', 'v' }, '<leader>cf', function()
            conform.format({
              lsp_fallback = true,
              async = false,
            })
          end, { desc = 'Format file or range (in visual mode)' })
        end
      end,
    })
  end,
}
