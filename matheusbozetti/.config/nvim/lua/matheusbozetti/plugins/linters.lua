return {
  'mfussenegger/nvim-lint',
  event = 'VeryLazy',
  config = function()
    local lint = require('lint')

    lint.linters_by_ft = {
      json = { 'jsonlint' },
      c = { 'cpplint' },
      cpp = { 'cpplint' },
      objc = { 'cpplint' },
      objcpp = { 'cpplint' },
      go = { 'golangcilint' },
    }

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost' }, {
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set('n', '<leader>cl', function()
      lint.try_lint()
    end, { desc = 'Lint the current file' })

    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = { '*.tsx', '*.ts', '*.jsx', '*.js', '*.vue' },
      command = 'silent! EslintFixAll',
      group = vim.api.nvim_create_augroup('MyAutocmdsJavaScripFormatting', {}),
    })
  end,
}
