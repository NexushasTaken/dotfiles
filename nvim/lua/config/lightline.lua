local nvim_icons = require'nvim-web-devicons'

vim.g.filetype = function()
  local ext = string.match(vim.fn.expand('%:t'), '^.*%.(.*)$')
  local name = vim.o.filetype
  if name == 'make' then name = 'makefile' end
  local icon, _ = nvim_icons.get_icon(name, ext)
  if icon then
    return icon..' '..vim.o.filetype
  end
  return 'no ft'
end

vim.g.lightline = {
  colorscheme = 'ayu_dark',
  active = {
    left = {
      { 'mode' },
      { 'filemod' },
      { 'lineperc' },
    },
    right = {
      { 'filetype' },
      { 'fileencoding' },
    },
  },
  tab = {
    active = { 'readonly', 'filename' },
    inactive = { 'readonly', 'filename' },
  },
  component = {
    mode = '%{lightline#mode()}',
    -- Filename + Modified
    filemod = '%t %M',
    readonly = '%R',
    fileencoding = '%{&fenc!=#""?&fenc:&enc}',
    -- Percent + Lineinfo
    lineperc = '%3p%% %3l:%-2c',
    filetype = '%{filetype()}',
  },
  separator = { left = ' ', right = ' ' },
  subseparator = { left = ' ', right = ' ' },
  tabline_separator = { left = '', right = '' },
  tabline_subseparator = { left = '', right = '' },
}
