local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move lines down in visual selection" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move lines up in visual selection" })

vim.keymap.set("v", "<C-u>", "<C-u>zz", { desc = "Move up in buffer and center cursor" })
vim.keymap.set("v", "<C-d>", "<C-d>zz", { desc = "Move down in buffer and center cursor" })

-- Goes to the next or previous occurence and center
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Navigate buffers to left and right
vim.keymap.set({ "v", "n" }, "<C-h>", "<cmd>bp<CR>", { desc = "Move buffer to the left" })
vim.keymap.set({ "v", "n" }, "<C-l>", "<cmd>bn<CR>", { desc = "Move buffer to the right" })

-- Identation in visual mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Paste without replace clipboard content
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without replace clipboard content" })

-- Prevents pasting of replace clipboard in visual mode
vim.keymap.set("v", "p", '"_dp', opts)

-- Delete without copying
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without copying" })

-- Exit insert mode
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Disable highlight on search in normalmode
vim.keymap.set("n", "<C-c>", ":nohl<CR>", { desc = "Clear search highlight", silent = true })

-- Buffer format
vim.keymap.set("n", "<leader>bf", vim.lsp.buf.format, { desc = "Format buffer" })

-- Prevents deleted characters from copying to clipboard
vim.keymap.set("n", "x", '"_x', opts)

-- Convert current file in executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Make file executable", silent = true })

-- Close current buffer
vim.keymap.set("n", "<leader>q", "<cmd>bd<CR>", { desc = "Quit (close) current buffer", silent = true })

-- Copy filepath to clipboard
vim.keymap.set("n", "<leader>fp", function()
	local filePath = vim.fn.expand("%:~")
	vim.fn.setreg("+", filePath)
	print("File path copied: " .. filePath)
end, { desc = "Copy filepath to clipboard" })

-- Highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
