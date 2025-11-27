local opt = vim.opt
local g = vim.g

g.mapleader = ' '

vim.cmd [[
    set nowrap
    set nobackup
    set nowritebackup
    set noerrorbells
    set noswapfile
]]

-- undo files
opt.undofile = true
opt.undodir = "/home/ni/.cache"

-- indentation
opt.smartindent = true
opt.autoindent = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- set clipboard to use system clipboard
opt.clipboard = "unnamedplus"

opt.mouse = "a"

opt.termguicolors = true
opt.cursorline = true
opt.number = true

opt.viminfo = ""
opt.viminfofile = "NONE"

opt.smartcase = true
opt.ttimeoutlen = 5
opt.compatible = false
opt.autoread = true
opt.incsearch = true 
opt.hidden = true
opt.shortmess = "atI"
