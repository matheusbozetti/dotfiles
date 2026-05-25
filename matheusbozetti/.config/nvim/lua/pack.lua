vim.pack.add({
	-- themes
	"https://github.com/bluz71/vim-moonfly-colors",
	"https://github.com/folke/tokyonight.nvim",
	"https://github.com/scottmckendry/cyberdream.nvim",
	--
	"https://github.com/nvim-mini/mini.nvim",
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" },
	"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
	"https://github.com/folke/snacks.nvim",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/saghen/blink.lib",
	{ src = "https://github.com/saghen/blink.cmp", branch = "v1.*" },
	"https://github.com/L3MON4D3/LuaSnip",
	"https://github.com/stevearc/conform.nvim",
})

local map = vim.keymap.set

---- MINI
local MiniFiles = require("mini.files")
MiniFiles.setup({
	windows = {
		preview = true,
		width_focus = 30,
		width_preview = 50,
	},
	mappings = {
		go_in = "<CR>",
		go_in_plus = "L",
		go_out = "_",
		go_out_plus = "H",
	},
})

map("n", "-", function()
	MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
	MiniFiles.reveal_cwd()
end, { desc = "Toggle into currently opened file" })

-- mini cmdline
require("mini.cmdline").setup({
	autocorrect = { enable = false },
})

-- mini surround
require("mini.surround").setup()

-- mini pairs
require("mini.pairs").setup()

-- mini comment
require("mini.comment").setup()

-- mini diff (git signs)
require("mini.diff").setup({
	view = { style = "sign" },
})

map("n", "<leader>gd", function()
	require("mini.diff").toggle_overlay()
end, { desc = "Toggle git diff overlay" })

-- mini statusline
local MiniStatusline = require("mini.statusline")
MiniStatusline.setup({
	use_icons = true,
	content = {
		active = function()
			local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
			local git = MiniStatusline.section_git({ trunc_width = 75 })
			local diff = MiniStatusline.section_diff({ trunc_width = 75 })
			local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
			local filename = MiniStatusline.section_filename({ trunc_width = 140 })
			local location = MiniStatusline.section_location({ trunc_width = 75 })

			local root = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
			local root_str = " " .. root
			local filetype = vim.bo.filetype ~= "" and (" " .. vim.bo.filetype) or ""

			return MiniStatusline.combine_groups({
				{ hl = mode_hl, strings = { mode } },
				{ hl = "MiniStatuslineDevinfo", strings = { root_str, git, diff } },
				"%<", -- truncation point
				{ hl = "MiniStatuslineFilename", strings = { filename } },
				"%=", -- right-align
				{ hl = "MiniStatuslineFileinfo", strings = { diagnostics } },
				{ hl = "MiniStatuslineFileinfo", strings = { filetype } },
				{ hl = mode_hl, strings = { location } },
			})
		end,
	},
})

-- mini clue (keymap hints)
local MiniClue = require("mini.clue")
MiniClue.setup({
	triggers = {
		{ mode = "n", keys = "<leader>" },
		{ mode = "x", keys = "<leader>" },
		{ mode = "n", keys = "g" },
		{ mode = "n", keys = "[" },
		{ mode = "n", keys = "]" },
	},
	window = {
		delay = 100,
	},
	clues = {
		MiniClue.gen_clues.builtin_completion(),
		MiniClue.gen_clues.g(),
		MiniClue.gen_clues.marks(),
		MiniClue.gen_clues.registers(),
		MiniClue.gen_clues.windows(),
	},
})

-- SNACKS (before blink.cmp so UI loads even if completion fails)
local Snacks = require("snacks")

Snacks.setup({
	bigfile = { enabled = true },
	quickfile = { enabled = true },

	dashboard = { enabled = true },
	picker = { enabled = true },
	notifier = { enabled = true },
	terminal = { enabled = true },
	zen = { enabled = true },
	indent = { enabled = true },
	words = { enabled = true },
	lazygit = { enabled = true },
	gitbrowse = { enabled = true },

	image = { enabled = false },
})

-- snacks picker
map("n", "<leader>fs", function()
	Snacks.picker.smart()
end, { desc = "Smart picker (files + buffers)" })

map("n", "<leader>ff", function()
	Snacks.picker.files()
end, { desc = "Find files" })

map("n", "<leader>fp", function()
	Snacks.picker.projects()
end, { desc = "Find projects" })

map("n", "<leader>fg", function()
	Snacks.picker.grep()
end, { desc = "Grep in project" })

map("n", "<leader><leader>", function()
	Snacks.picker.buffers()
end, { desc = "Find open buffers" })

map("n", "<leader>sd", function()
	Snacks.picker.diagnostics_buffer()
end, { desc = "Search buffer diagnostics" })

map("n", "<leader>sn", function()
	Snacks.picker.notifications()
end, { desc = "Search notifications" })

map("n", "<leader>sk", function()
	Snacks.picker.keymaps()
end, { desc = "Search keymaps" })

map("n", "<leader>sh", function()
	Snacks.picker.help()
end, { desc = "Search help tags" })

-- explorer
map("n", "<leader>fe", function()
	Snacks.explorer()
end, { desc = "Open file explorer" })

-- zen mode
map("n", "<leader>z", function()
	Snacks.zen()
end, { desc = "Toggle zen mode" })

-- terminal
map("n", "<leader>tt", function()
	Snacks.terminal()
end, { desc = "Toggle terminal" })

-- git
map("n", "<leader>gl", function()
	Snacks.lazygit()
end, { desc = "Open lazygit" })

map("n", "<leader>gb", function()
	Snacks.gitbrowse()
end, { desc = "Open file in browser (git)" })

-- blink.cmp completion
local blink_ok, blink_err = pcall(function()
	require("blink.cmp").setup({
		keymap = {
			preset = "default",
			["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			["<CR>"] = { "accept", "fallback" },
			["<C-Space>"] = { "show", "fallback" },
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		snippets = { preset = "luasnip" },
		completion = {
			menu = { border = "rounded" },
			documentation = { auto_show = true },
		},
	})
end)
if not blink_ok then
	vim.notify("blink.cmp: " .. tostring(blink_err), vim.log.levels.WARN)
end

require("treesitter")
require("lsp")
