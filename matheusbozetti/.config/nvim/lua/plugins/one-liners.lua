-- Default file for simple plugins
return {
	{ "tribela/vim-transparent" }, -- add transparency to neovim
	{ "cohama/lexima.vim" }, -- autopairs {}, [], ()
	{ "windwp/nvim-ts-autotag", config = true }, -- auto close tag HTML, Vue, react...
	{ "folke/which-key.nvim", event = "VeryLazy", opts = {} },
	{
		"j-hui/fidget.nvim",
		opts = {
			notification = {
				window = {
					winblend = 0,
				},
			},
		},
	},
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
			"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
		},
		init = function()
			vim.g.barbar_auto_setup = true
		end,
		version = "^1.0.0", -- optional: only update when a new 1.x version is released
	},
	{
		"mg979/vim-visual-multi",
	},
}
