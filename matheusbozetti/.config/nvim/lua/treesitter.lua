require("nvim-treesitter").install({
    "lua",
    "bash",
    "yaml",
    "json",
    "toml",
    "go",
    "javascript",
    "typescript",
    "tsx",
    "rust",
    "odin",
    "css",
    "scss",
    "html",
    "vue",
    "markdown",
    "vim",
    "vimdoc",
})

-- highlight: only langs where TS clearly improves on regex.
-- moonfly maps regex groups (Function/Identifier) well but has weak coverage
-- for @-prefixed TS groups, so we keep regex+LSP semantic tokens for web langs.
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "go", "rust", "toml", "bash", "yaml", "json", "odin", "lua", "markdown" },
    callback = function(ev)
        pcall(vim.treesitter.start, ev.buf)
    end,
})

-- parser-only (no highlighter): keeps textobjects/queries working in web langs
-- without overriding moonfly's tuned regex syntax.
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "javascript", "javascriptreact",
        "typescript", "typescriptreact", "tsx",
        "vue", "css", "scss", "html",
    },
    callback = function(ev)
        pcall(vim.treesitter.get_parser, ev.buf)
    end,
})

-- textobjects global config
require("nvim-treesitter-textobjects").setup({
    select = { lookahead = true },
    move  = { set_jumps = true },
})

local select = require("nvim-treesitter-textobjects.select")
local move   = require("nvim-treesitter-textobjects.move")

-- select text objects (normal + operator-pending)
local sel_maps = {
    ["af"] = "@function.outer",
    ["if"] = "@function.inner",
    ["ac"] = "@class.outer",
    ["ic"] = "@class.inner",
    ["aa"] = "@parameter.outer",
    ["ia"] = "@parameter.inner",
}
for key, query in pairs(sel_maps) do
    vim.keymap.set({ "x", "o" }, key, function()
        select.select_textobject(query, "textobjects")
    end, { desc = "Select " .. query })
end

-- move between functions
vim.keymap.set("n", "]f", function()
    move.goto_next_start("@function.outer", "textobjects")
end, { desc = "Next function start" })

vim.keymap.set("n", "[f", function()
    move.goto_previous_start("@function.outer", "textobjects")
end, { desc = "Previous function start" })
