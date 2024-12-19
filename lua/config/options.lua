-- Set various Neovim options
local opt = vim.opt

-- Cursor
opt.guicursor = "" -- Use block cursor in all modes

-- Line numbers
opt.nu = true -- Show line numbers
-- opt.relativenumber = true -- Uncomment to use relative line numbers

-- Indentation
opt.tabstop = 4 -- Number of spaces a tab counts for
opt.softtabstop = 4 -- Number of spaces a tab counts for while editing
opt.shiftwidth = 4 -- Number of spaces to use for autoindent
opt.expandtab = true -- Use spaces instead of tabs
opt.smartindent = true -- Insert indents automatically

-- Line wrapping
-- opt.wrap = false -- Uncomment to disable line wrapping

-- Backup and undo
opt.swapfile = false -- Disable swap file
opt.backup = false -- Disable backup file
-- opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Set undo directory
opt.undofile = true -- Enable persistent undo

-- Search
opt.hlsearch = false -- Disable highlight search
opt.incsearch = true -- Enable incremental search
opt.ignorecase = true -- Ignore case in search patterns
opt.smartcase = true -- Override ignorecase if search pattern contains upper case characters

-- Appearance
opt.termguicolors = true -- Enable 24-bit RGB color in the TUI

-- Scrolling
opt.scrolloff = 8 -- Minimum number of lines to keep above and below the cursor
opt.signcolumn = "yes" -- Always show the sign column

-- File handling
opt.isfname:append("@-@") -- Consider '@' as part of filename for gf command

-- Performance
opt.updatetime = 50 -- Faster completion

-- Visual guides
opt.colorcolumn = "80" -- Show a vertical line at column 80

-- Python provider for some plugins
vim.g.python3_host_prog = "/usr/bin/python3"

-- Netrw tree mode
-- vim.g.netrw_liststyle = 3
-- vim.g.netrw_winsize = 25
