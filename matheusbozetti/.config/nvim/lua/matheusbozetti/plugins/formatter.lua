return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  cmd = { 'ConformInfo' },
  config = function()
    local conform = require('conform')

    local formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'isort', 'black' },
      javascript = { { 'prettier', 'prettierd' } },
      typescript = { { 'prettier', 'prettierd' } },
      vue = { { 'prettier', 'prettierd' } },
    }

    local format_on_save = {
      lsp_fallback = true,
      async = false,
    }

    conform.setup({
      formatters_by_ft = formatters_by_ft,
      format_on_save = format_on_save,
    })

    vim.keymap.set({ 'n', 'v' }, '<leader>cf', function()
      conform.format({
        lsp_fallback = true,
        async = false,
      })
    end, { desc = 'Format file or range (in visual mode)' })
  end,
}
