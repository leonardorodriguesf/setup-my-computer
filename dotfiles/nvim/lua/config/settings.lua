-- Make jumping between lines easier
vim.opt.number = true
vim.opt.relativenumber = true

-- Use spaces instead of tabs
vim.opt.expandtab = true

-- Set the number of spaces that a <Tab> counts for
vim.opt.tabstop = 2

-- Set the number of spaces to use for each step of (auto)indent
vim.opt.shiftwidth = 2

-- Set the number of spaces that a <Tab> counts for while editing
vim.opt.softtabstop = 2

-- Makes searches case-insensitive
vim.opt.ignorecase = true

-- Makes searchs case-sensitive if the search string contains uppercase letters
vim.opt.smartcase = true

vim.opt.autoindent = true

-- Remove explorer (netrw) header
vim.g.netrw_banner = false

-- Set infinite undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim"
vim.opt.undofile = true

vim.opt.colorcolumn = "80"

vim.opt.termguicolors = true
