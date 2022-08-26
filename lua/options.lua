local set = vim.opt

set.guifont = { "JetBrainsMono NF", ":h11" }

-- Better editor UI
set.number = true
set.numberwidth = 2
set.relativenumber = true
-- set.signcolumn = 'yes'
set.cursorline = true
set.autochdir = true

-- Better editing experience
set.expandtab = true
set.smarttab = true
set.cindent = true
set.autoindent = true
set.wrap = true
set.textwidth = 300
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = -1 -- If negative, shiftwidth value is used
--set.list = true
set.listchars = {eol = '↲', tab = '▸ ', trail = '·'}
set.mouse="a"

-- Makes neovim and host OS clipboard play nicely with each other
set.clipboard = 'unnamedplus'

-- Case insensitive searching UNLESS /C or capital in search
set.ignorecase = true
set.smartcase = true

-- Undo and backup options
set.backup = false
set.writebackup = false
set.undofile = true
set.swapfile = false
-- set.backupdir = '/tmp/'
-- set.directory = '/tmp/'
-- set.undodir = '/tmp/'

-- Remember 50 items in commandline history
set.history = 50

-- Better buffer splitting
set.splitright = true
set.splitbelow = true




-- no animation needed
vim.g.neovide_cursor_animation_length=0 
vim.g.neovide_cursor_trail_length=0

vim.cmd [[
    hi VertSplit guibg=NONE guifg=#141414
    set termguicolors
    set background=dark " or light
    colorscheme zenbones
]]

