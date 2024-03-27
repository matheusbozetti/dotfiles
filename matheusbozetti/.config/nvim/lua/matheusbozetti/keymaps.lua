local nvimSetKeymap = vim.api.nvim_set_keymap
local vimSetKeymap = vim.keymap.set

nvimSetKeymap('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection up', noremap = true, silent = true })
nvimSetKeymap('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection down', noremap = true, silent = true })

vimSetKeymap('n', '<leader>pv', vim.cmd.Ex, { desc = 'Open vertical NetEW' })
vimSetKeymap('n', '<C-d>', '<C-d>zz', { desc = 'Move down and center' })
vimSetKeymap('n', '<C-u>', '<C-u>zz', { desc = 'Move up and center' })

vimSetKeymap('n', '<M-S-j>', '5j', { desc = 'Move down 5 lines' })
vimSetKeymap('n', '<M-S-k>', '5k', { desc = 'Move up 5 lines' })

vimSetKeymap('n', '<leader>p', '"_dP', { desc = 'Change the highlighted text with the previous copied' })

vimSetKeymap('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Search and replace' })

vimSetKeymap('n', '<C-s>', ':w<CR>', { desc = 'Save buffer' })
vimSetKeymap('n', '<C-l>', ':bnext<CR>', { desc = 'Next buffer' })
vimSetKeymap('n', '<C-h>', ':bprev<CR>', { desc = 'Previous buffer' })
vimSetKeymap('n', '<leader>q', ':bd<CR>', { desc = 'Close current buffer' })

vimSetKeymap('n', '<M-j>', ':resize -4<CR>', { desc = 'Resize window down' })
vimSetKeymap('n', '<M-k>', ':resize +4<CR>', { desc = 'Resize window up' })
vimSetKeymap('n', '<M-h>', ':vertical resize +4<CR>', { desc = 'Resize window left' })
vimSetKeymap('n', '<M-l>', ':vertical resize -4<CR>', { desc = 'Resize window right' })
