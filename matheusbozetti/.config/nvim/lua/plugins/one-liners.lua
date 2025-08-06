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
}
