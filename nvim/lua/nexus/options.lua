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
opt.showmode = false
opt.autochdir = false
opt.compatible = false
opt.foldlevel = 999999
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.showtabline = 2
opt.scrolloff = 2
opt.expandtab = fn.tolower(fn.expand'#') ~= 'makefile'
opt.directory = fn.getcwd()..'/.swaps'

g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.python_recommended_style = 0
g.rust_recommended_style = 0
g.loaded_z_defaults = 1

fn.setenv('MANWIDTH', 94)
