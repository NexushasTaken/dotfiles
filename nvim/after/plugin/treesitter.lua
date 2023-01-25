require'nvim-treesitter.configs'.setup{
  auto_install = true,
  highlight = {
    enable = true,
    use_languagetree = true,
    additional_vim_regex_highlighting = true,
  },
  rainbow = {
    enable = true,
    disable = { 'html' };
    extended_mode = true,
  }
}
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'