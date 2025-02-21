vim.g.mapleader = " "

vim.keymap.set("n", "<leader>r", vim.cmd.CccPick)

-- vim.keymap.set("n", "<C-x>", vim.cmd.Ex)
vim.keymap.set("n", "<C-q>", vim.cmd.q)
vim.keymap.set("n", "<C-s>", vim.cmd.w)
vim.keymap.set("n", "<leader>c", vim.cmd.noh)

vim.keymap.set("n", "<C-b>", ":NvimTreeToggle<cr>")

vim.keymap.set("v", "<C-Up>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<C-Down>", ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "<C-S-k>", "dd")
vim.keymap.set("i", "<C-S-k>", "<Esc>dd")
vim.keymap.set("v", "<C-S-k>", "d")

vim.keymap.set("n", "<C-a>", "ggVG")

vim.keymap.set("n", "<C-S-Down>", "Vyp")
vim.keymap.set("n", "<C-S-Up>", "VyP")
-- vim.keymap.set("v", "<C-S-Down>", "Vyp")
-- vim.keymap.set("v", "<C-S-Up>", "VyP")

vim.keymap.set("n", "J", "mzJ`z")
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- vim.api.nvim_set_keymap('n', '<C-S-c>', '<C-\\><C-o>"+y', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<C-S-v>', '<C-\\><C-o>"+p', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('v', '<C-S-c>', '<C-\\><C-o>"+y', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('v', '<C-S-v>', '<C-\\><C-o>"+p', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('i', '<C-S-c>', '<C-\\><C-o>"+y', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('i', '<C-S-v>', '<C-\\><C-o>"+p', { noremap = true, silent = true })

vim.keymap.set('v', '<C-S-c>', '"+y')    -- Copy
vim.keymap.set('n', '<C-S-v>', '"+P')    -- Paste normal mode
vim.keymap.set('v', '<C-S-v>', '"+P')    -- Paste visual mode
vim.keymap.set('c', '<C-S-v>', '<C-R>+') -- Paste command mode
vim.keymap.set('i', '<C-S-v>', '<C-R>+') -- Paste insert mode

vim.keymap.set('n', '<leader>n', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>m', vim.diagnostic.goto_prev)

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<F3>", "<C-w><C-v>")
vim.keymap.set("n", "<F4>", "<C-w><C-s>")
vim.keymap.set("n", "<C-Right>", "<C-w><Right>")
vim.keymap.set("n", "<C-Left>", "<C-w><Left>")

vim.keymap.set("n", "<C-z>", "u")
vim.keymap.set("i", "<C-z>", "<Esc>u")

vim.keymap.set("n", "<C-y>", function() require('Comment.api').toggle.linewise.current() end, { noremap = true, silent = true })
vim.keymap.set("i", "<C-y>", function() require('Comment.api').toggle.linewise.current() end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
