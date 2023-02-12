local Plug = vim.fn['plug#']
vim.call'plug#begin'
--Plug'ghifarit53/tokyonight-vim' -- Theme
Plug'folke/tokyonight.nvim' -- Theme
Plug'nvim-treesitter/nvim-treesitter' -- Better syntax highlighting
Plug'itchyny/lightline.vim' -- Status line
Plug'nkakouros-original/numbers.nvim' -- Relative numbers disabler
Plug'natecraddock/sessions.nvim' -- Session Manager
Plug'windwp/nvim-autopairs' -- Auto close chars
Plug'godlygeek/tabular' -- Fix tab formats
Plug'jghauser/mkdir.nvim' -- Make dirs when saving files
Plug'windwp/nvim-ts-autotag' -- Auto close tag
Plug'andymass/vim-matchup' -- Highlight pairs
Plug'kyazdani42/nvim-web-devicons' -- Icons
Plug'mbbill/undotree' -- Undo tree
Plug'nvim-tree/nvim-tree.lua' -- File browser
Plug'nvim-telescope/telescope.nvim' -- Fuzzy finder
Plug'sheerun/vim-polyglot' -- Better language support

-- LSP Support
Plug'neovim/nvim-lspconfig'
Plug'williamboman/mason.nvim'
Plug'williamboman/mason-lspconfig.nvim'

-- Autocompletion
Plug'hrsh7th/nvim-cmp'
Plug'hrsh7th/cmp-buffer'
Plug'hrsh7th/cmp-path'
Plug'saadparwaiz1/cmp_luasnip'
Plug'hrsh7th/cmp-nvim-lsp'
Plug'hrsh7th/cmp-nvim-lua'

-- Snippets
Plug'L3MON4D3/LuaSnip'
Plug'rafamadriz/friendly-snippets'

Plug'VonHeikemen/lsp-zero.nvim'
Plug'nvim-lua/plenary.nvim' -- Some tools for Lua?
Plug'manzeloth/live-server' -- Live server
vim.call'plug#end'
