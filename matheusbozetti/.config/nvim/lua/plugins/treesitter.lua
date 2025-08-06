return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				sync_install = true,
				auto_install = true,
				ensure_installed = {
					"lua",
					"bash",
					"yaml",
					"json",
					"go",
					"javascript",
					"typescript",
					"css",
					"scss",
					"html",
					"vue",
					"markdown",
					"vim",
					"vimdoc",
				},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
			})
		end,
	},
}
