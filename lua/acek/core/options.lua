vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.background = "light"

-- line numbers
opt.relativenumber = true
opt.number = true

-- Tabs & Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

opt.wrap = false

-- Search Settings
opt.ignorecase = true
opt.smartcase = true

opt.cursorline = false

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- Backspace
opt.backspace = "indent,eol,start"

-- Clipboard
opt.clipboard:append("unnamedplus")

-- Panes
opt.splitright = true -- Split window to the right
opt.splitbelow = true -- Split window to the bottom
