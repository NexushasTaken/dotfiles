local opt = vim.opt
local fn = vim.fn
local g = vim.g

opt.magic = true
opt.number = true
opt.undofile = true
opt.smartcase = true
opt.linebreak = true
opt.shiftround = true
opt.autoindent = true
opt.cursorline = true
opt.equalalways = true
opt.termguicolors = true
opt.relativenumber = true
opt.wrap = false
opt.backup = false
opt.timeout = false
opt.foldlevel = 0
opt.autochdir = false
opt.compatible = false
opt.showmode = false
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.showtabline = 2
opt.scrolloff = 2
opt.undodir = fn.getenv'HOME'..'/.config/nvim/.vim_undoes'
opt.expandtab = fn.tolower(fn.expand'#') ~= 'makefile'
opt.directory = fn.getcwd()

g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.python_recommended_style = 0
g.rust_recommended_style = 0

fn.setenv('MANWIDTH', 94)
