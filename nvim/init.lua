local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/.plugged')
Plug'folke/tokyonight.nvim' -- Theme
Plug'kyazdani42/nvim-tree.lua' -- File Explorer
Plug'natecraddock/sessions.nvim' -- Session Manager
Plug'norcalli/nvim-colorizer.lua' -- Add color to the color codes
Plug'lewis6991/gitsigns.nvim' -- Git
Plug'andweeb/presence.nvim' -- Discord Presence

Plug'phaazon/hop.nvim' -- Hopper
Plug'ray-x/web-tools.nvim' -- Webpage previewer
Plug'nkakouros-original/numbers.nvim' -- Disable relative number when they don't make sense
Plug'windwp/nvim-autopairs' -- Auto close chars
Plug'itchyny/lightline.vim' -- Lightline

-- Snippet + Autocompletion
Plug'hrsh7th/nvim-cmp'
Plug'saadparwaiz1/cmp_luasnip'
Plug'L3MON4D3/LuaSnip'
Plug'hrsh7th/cmp-path'

-- No config needed plugins {
Plug'kyazdani42/nvim-web-devicons' -- Icons
Plug'godlygeek/tabular' -- Fix tab formats
Plug'jghauser/mkdir.nvim' -- Make dirs when saving files
Plug'davidgranstrom/nvim-markdown-preview' -- Markdown Preview
Plug'kdheepak/lazygit.nvim' -- Lazygit
Plug'prettier/vim-prettier' -- Prettier
Plug'sakhnik/nvim-gdb'

-- Telescope
Plug'nvim-telescope/telescope.nvim'
Plug'nvim-lua/plenary.nvim'
-- }

-- Treesitter {
Plug'windwp/nvim-ts-autotag' -- Auto close tag
Plug'm-demare/hlargs.nvim' -- Arguments highlighter
Plug'nvim-treesitter/nvim-treesitter'

Plug'lukas-reineke/indent-blankline.nvim' -- Indent line
Plug'p00f/nvim-ts-rainbow' -- Different colors for pairs
Plug'andymass/vim-matchup' -- Highlight pairs
-- }
-- Lsp {
Plug'neovim/nvim-lspconfig'
Plug'hrsh7th/cmp-nvim-lsp'
Plug'mfussenegger/nvim-dap'

-- rust
Plug'simrat39/rust-tools.nvim'
-- C/C++
Plug'p00f/clangd_extensions.nvim'
-- C#
Plug'Hoffs/omnisharp-extended-lsp.nvim'
-- Typescript
Plug'jose-elias-alvarez/typescript.nvim'
-- Godot
Plug'habamax/vim-godot'
-- }
vim.call('plug#end')

vim.cmd'colorscheme tokyonight-night'

require'config.mappings'
require'config.nvimtree'
require'config.colorizer'
require'config.luasnip'
require'config.treesitter'
require'config.lspconfig'
require'config.lightline'
require'config.options'

-- Direct plugin setups
require'hop'.setup()
require'hlargs'.setup()
require'web-tools'.setup()
require'numbers'.setup()
require'nvim-autopairs'.setup()
--[[require'gitsigns'.setup{
  signcolumn = false, numhl = true,
}]]
require'sessions'.setup()
require'presence':setup{}
