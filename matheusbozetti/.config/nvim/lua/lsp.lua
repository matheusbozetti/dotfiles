require("mason").setup()

local servers = {
	"lua_ls",
	"marksman",
	"gopls",
	"rust_analyzer",
	"taplo",
	"vtsls",
	"eslint",
	"jsonls",
	"cssls",
	"html",
}

pcall(function()
	require("mason-lspconfig").setup({
		ensure_installed = servers,
		automatic_installation = true,
	})
end)

-- Diagnostics
vim.diagnostic.config({
	virtual_text = { prefix = "●", spacing = 2 },
	underline = true,
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN]  = " ",
			[vim.diagnostic.severity.HINT]  = " ",
			[vim.diagnostic.severity.INFO]  = " ",
		},
	},
	float = { border = "rounded", source = "if_many" },
})

-- Capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

local blink_ok, blink = pcall(require, "blink.cmp")
if blink_ok then
	capabilities = blink.get_lsp_capabilities(capabilities)
end

vim.lsp.config("*", {
	capabilities = capabilities,
})

-- Lua LS
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

-- Vue / TS
local mason_path = vim.fn.stdpath("data") .. "/mason"

local vue_ts_plugin_path = mason_path .. "/packages/vue-language-server/node_modules/@vue/language-server"

local vue_plugin = {
	name = "@vue/typescript-plugin",
	location = vue_ts_plugin_path,
	languages = { "vue" },
	configNamespace = "typescript",
}

vim.lsp.config("vtsls", {
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = {
					vue_plugin,
				},
			},
		},
	},

	filetypes = {
		"typescript",
		"javascript",
		"javascriptreact",
		"typescriptreact",
		"vue",
	},
})

-- Enable servers
vim.lsp.enable(servers)

-- Keymaps
local Snacks = require("snacks")
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = desc })
		end

		map("gd", Snacks.picker.lsp_definitions, "Definitions")
		map("gr", Snacks.picker.lsp_references, "References")
		map("gI", Snacks.picker.lsp_implementations, "Implementations")
		map("gt", Snacks.picker.lsp_type_definitions, "Type Definitions")

		map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
		map("<leader>cf", function()
			require("conform").format({ async = true, lsp_fallback = true })
		end, "Format Buffer")
		map("<leader>ce", "<cmd>EslintFixAll<cr>", "Fix ESLint errors")

		map("df", vim.diagnostic.open_float, "Diagnostics")

		map("[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Prev Diagnostic")
		map("]d", function() vim.diagnostic.jump({ count =  1, float = true }) end, "Next Diagnostic")

		if vim.lsp.inlay_hint then
			vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(
					not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }),
					{ bufnr = ev.buf }
				)
			end, "Toggle inlay hints")
		end
	end,
})
