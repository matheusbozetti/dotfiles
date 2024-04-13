return {
  'mfussenegger/nvim-lint',
  event = 'VeryLazy',
  config = function()
    local lint = require('lint')

    lint.linters_by_ft = {
      javascript = { 'eslint' },
      javascriptreact = { 'eslint' },
      typescript = { 'eslint' },
      typescriptreact = { 'eslint' },
      c = { 'cpplint' },
      cpp = { 'cpplint' },
      objc = { 'cpplint' },
      objcpp = { 'cpplint' },
    }

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost' }, {
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set('n', '<leader>cl', function()
      lint.try_lint()
    end, { desc = 'Lint the current file' })
  end,
}
