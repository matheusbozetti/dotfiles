-- Reset config
vim.keymap.set("n", "<leader>re", "<cmd>restart<cr>", { desc = "Restart config :restart)" })

-- Paste without replace clipboard content
vim.keymap.set("x", "p", [["_dP]], { desc = "Paste without replace clipboard content" })

-- Goes to the next or previous occurence and center
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result and center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result and center" })

-- Move lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move lines down in visual selection" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move lines up in visual selection" })

-- Move up and down in buffer and center the cursor
vim.keymap.set("v", "<C-u>", "<C-u>zz", { desc = "Move up in buffer and center cursor" })
vim.keymap.set("v", "<C-d>", "<C-d>zz", { desc = "Move down in buffer and center cursor" })

-- Delete without copying
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without copying" })

-- Exit insert mode
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Exit insert mode" })

-- Disable highlight on search in normalmode
vim.keymap.set("n", "<C-c>", ":nohl<CR>", { desc = "Clear search highlight", silent = true })

-- Identation in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Replace word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word cursor is on globally" })

-- Make file executable
vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Makes file executable" })

-- Write current buffer
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Write buffer", silent = true })

-- Source current file (handy for editing this config)
vim.keymap.set("n", "<leader>x", "<cmd>source %<CR>", { desc = "Source current file" })

-- Close current buffer
vim.keymap.set("n", "<leader>q", "<cmd>bd<CR>", { desc = "Quit (close) current buffer", silent = true })

-- Navigate buffers to left and right
vim.keymap.set({ "v", "n" }, "<C-h>", "<cmd>bp<CR>", { desc = "Move buffer to the left" })
vim.keymap.set({ "v", "n" }, "<C-l>", "<cmd>bn<CR>", { desc = "Move buffer to the right" })


