vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "Lsp: " .. desc })
		end

		local tele = require("telescope.builtin")
		map("gd", tele.lsp_definitions, "[G]oto [D]efinition")
		map("gt", tele.lsp_type_definitions, "[G]oto [T]ype definitions")
		map("gr", tele.lsp_references, "[G]oto [R]eferences")
		map("gI", tele.lsp_implementations, "[G]oto [I]mplementation")
		map("ge", vim.diagnostic.open_float, "Open [E]rror diagnostic")

		map("K", vim.lsp.buf.hover, "hover")
		map("<leader>ca", vim.lsp.buf.code_action, "code action")
		map("[d", vim.diagnostic.goto_prev, "[D]iagnostic [P]rev")
		map("]d", vim.diagnostic.goto_next, "[D]iagnostic [N]ext")

		vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "Lsp: [C]ode [A]ction" })
	end,
})

local mason_path = vim.fn.stdpath("data") .. "/mason"
local vue_ts_plugin_path = mason_path .. "/packages/vue-language-server/node_modules/@vue/language-server"

-- Packages installed by default
local masonAlwaysInstalled = { "gopls", "dockerls", "vtsls", "lua_ls" }

return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
			servers = {
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				},
			},
		},
		config = function(_, opts)
			require("mason").setup(opts)
			require("mason-lspconfig").setup({
				ensure_installed = masonAlwaysInstalled,
				automatic_enable = {
					exclude = {
						"vtsls",
						"vue_ls",
					},
				},
			})

			local vue_plugin = {
				name = "@vue/typescript-plugin",
				location = vue_ts_plugin_path,
				languages = { "vue" },
				configNamespace = "typescript",
			}

			local vtsls_config = {
				settings = {
					vtsls = {
						tsserver = {
							globalPlugins = {
								vue_plugin,
							},
						},
					},
				},
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
			}

			vim.lsp.config("vtsls", vtsls_config)
			vim.lsp.config("vue_ls", {})
			vim.lsp.enable({ "vtsls", "vue_ls" })

			for server, config in pairs(opts.servers) do
				if server == "vue_ls" then
					return
				end
				if server == "vtsls" then
					return
				end

				vim.lsp.config(server, config)
				vim.lsp.enable(server)
			end
		end,
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "LspAttach",
		priority = 500,
		config = function()
			require("tiny-inline-diagnostic").setup()
			vim.diagnostic.config({ virtual_text = false })
		end,
	},
}
