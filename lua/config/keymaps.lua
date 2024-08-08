-- Alias for setting keymaps
local map = vim.keymap.set

-- File explorer
map("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer" })

-- Move selected lines up and down in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

-- Keep cursor in place when joining lines
map("n", "J", "mzJ`z", { desc = "Join lines and keep cursor in place" })

-- Scrolling
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down half a page and center cursor" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up half a page and center cursor" })

-- Keep search terms in the middle when jumping
map("n", "n", "nzzzv", { desc = "Jump to next search result and center" })
map("n", "N", "Nzzzv", { desc = "Jump to previous search result and center" })

-- Paste without yanking the replaced text
map("x", "<leader>p", [["_dP]], { desc = "Paste without yanking replaced text" })

-- Exit insert mode with Ctrl+c
map("i", "<C-c>", "<Esc>", { desc = "Exit insert mode" })
