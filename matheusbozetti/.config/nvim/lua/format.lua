require("conform").setup({
    formatters_by_ft = {
        lua        = { "stylua" },
        go         = { "goimports", "gofmt" },
        rust       = { "rustfmt" },
        typescript = { "prettier" },
        javascript = { "prettier" },
        vue        = { "prettier" },
        css        = { "prettier" },
        scss       = { "prettier" },
        html       = { "prettier" },
        json       = { "prettier" },
        toml       = { "taplo" },
        markdown   = { "prettier" },
    },
    format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
        end
        return { timeout_ms = 500, lsp_fallback = true }
    end,
})
