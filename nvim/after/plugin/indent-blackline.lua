require'indent_blankline'.setup{
  show_current_context = true,
}
vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_filetype_exclude = {
  'lspinfo',
  'checkhealth',
  'help',
  'man',
}
vim.g.indent_blankline_filetype_exclude = {
  "terminal",
  "nofile",
  "quickfix",
  "prompt",
}
