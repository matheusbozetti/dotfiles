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
            javascript = { { 'prettierd', 'prettier' } },
            javascriptreact = { { 'prettierd', 'prettier' } },
            typescript = { { 'prettierd', 'prettier' } },
            typescriptreact = { { 'prettierd', 'prettier' } },
            vue = { { 'prettierd', 'prettier' } },
            c = { 'clang-format' },
            cpp = { 'clang-format' },
            objc = { 'clang-format' },
            objcpp = { 'clang-format' },
            go = { 'goimports', 'gofmt' },
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

        conform.setup({
            log_level = vim.log.levels.DEBUG,
            formatters_by_ft = formatters_by_ft,
            format_on_save = format_on_save,
        })

        vim.keymap.set({ 'n', 'v' }, '<leader>cf', function()
            conform.format({
                lsp_fallback = true,
                async = false,
            })
        end, { desc = 'Format file or range (in visual mode)' })

        vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
            pattern = '*',
            callback = function()
                conform.format({
                    lsp_fallback = true,
                    async = false,
                })
            end,
        })
    end,
}
