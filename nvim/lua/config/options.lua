local opt = vim.opt

opt.softtabstop    = 2
opt.tabstop        = 2
opt.shiftwidth     = 2
opt.showtabline    = 2
opt.scrolloff      = 2
opt.number         = true
opt.relativenumber = true
opt.autoindent     = true
opt.cursorline     = true
opt.shiftround     = true
opt.magic          = true
opt.undofile       = true
opt.smartcase      = true
opt.termguicolors  = true
opt.swapfile       = true
opt.equalalways    = true
opt.linebreak      = true
opt.wrap           = true
opt.autochdir      = false
opt.backup         = false
opt.showmode       = false
opt.autochdir      = false
opt.foldenable     = false
opt.directory      = vim.fn.getcwd()
opt.undodir        = os.getenv('HOME') .. '/.config/nvim/.vim_undoes'
opt.mouse          = 'a'
opt.completeopt    = 'menu,menuone,noselect'
opt.cursorlineopt  = 'line'
opt.expandtab      = vim.o.filetype ~= 'make'
opt.foldmethod     = 'expr'
opt.foldexpr       = 'nvim_treesitter#foldexpr()'
