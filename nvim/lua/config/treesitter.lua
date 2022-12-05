require'nvim-treesitter.install'.prefer_git = true
require'nvim-treesitter.configs'.setup{
  auto_install = true,
  indent = { enable = true },
  autotag = { enable = true },
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
vim.cmd [[
hi rainbowcol1 guifg=#cc0000
hi rainbowcol2 guifg=#cc7200
hi rainbowcol2 guifg=#cccc00
hi rainbowcol3 guifg=#00cc00
hi rainbowcol4 guifg=#0000ff
hi rainbowcol5 guifg=#7e33b5
hi rainbowcol6 guifg=#af00ff
hi rainbowcol7 guifg=#00cccc
]]
