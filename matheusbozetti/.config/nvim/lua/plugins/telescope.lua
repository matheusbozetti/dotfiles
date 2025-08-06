return {
	-- Fuzzy Finder (files, lsp, etc)
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		require("telescope").setup({
			pickers = {
				colorscheme = {
					enable_preview = true,
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
			defaults = {
				file_ignore_patterns = { "node_modules/*", ".git/*", ".vscode/*", "dist/*", ".idea/*", "build/*" },
				path_display = { "truncate" },
				sorting_strategy = "ascending",
				layout_config = {
					horizontal = { prompt_position = "top", preview_width = 0.6 },
					vertical = { mirror = false },
					width = 0.87,
					height = 0.8,
					preview_cutoff = 120,
				},
				preview = {
					treesitter = true, -- TODO: disable when update treesitter to main branch
				},
			},
		})

		-- Enable telescope extensions, if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		-- See `:help telescope.builtin`
		local builtin = require("telescope.builtin")
		-- Search normal files
		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [f]iles" })
		-- Search all files (includin dot files -> E.g. .env)
		vim.keymap.set(
			"n",
			"<leader>sF",
			":Telescope find_files find_command=rg,--ignore,--hidden,--files,-u<CR>",
			{ desc = "[S]earch all [F]iles (Even Hidden)" }
		)
		vim.keymap.set(
			"n",
			"<leader>sd",
			":Telescope find_files find_command=fd,--type,d<CR>",
			{ desc = "[S]earch [D]irectory" }
		)
		vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
		vim.keymap.set("v", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		vim.keymap.set("n", "<leader>sw", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>sg", builtin.git_files, { desc = "[S]earch in [G]it" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
		vim.keymap.set("n", "<leader>st", builtin.diagnostics, { desc = "[S]earch Diagnos[t]ics" })
		vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
		vim.keymap.set("n", "<leader>sr.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
		vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
		vim.keymap.set("n", "<leader>fc", builtin.colorscheme, { desc = "[C] Find Colorschemes" })
		vim.keymap.set("n", "<leader>fv", builtin.lsp_document_symbols, { desc = "[V] Find Variables (Symbols)" })

		-- Slightly advanced example of overriding default behavior and theme
		vim.keymap.set("n", "<leader>/", function()
			-- You can pass additional configuration to telescope to change theme, layout, etc.
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })

		-- Also possible to pass additional configuration options.
		--  See `:help telescope.builtin.live_grep()` for information about particular keys
		vim.keymap.set("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "[S]earch [/] in Open Files" })

		-- Shortcut for searching your neovim configuration files
		vim.keymap.set("n", "<leader>sn", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[S]earch [N]eovim files" })
	end,
}
