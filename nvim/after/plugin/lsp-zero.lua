local notify = vim.notify
local lsp = require('lsp-zero')
local p = true
local types = require'cmp.types'

lsp.preset'recommended'
lsp.setup_servers{
  'clangd',
}
lsp.configure('clangd', {
  cmd = {
    'clangd',
    '--enable-config',
    --[['--clang-tidy', '--completion-style=detailed', '--header-insertion=never', '--pch-storage=memory', '--all-scopes-completion']]
    }
})
lsp.configure('hls', {
  cmd = { vim.fn.getenv'HOME'..'/.ghcup/bin/haskell-language-server-wrapper', '--lsp'}
})
lsp.setup_nvim_cmp{
  documentation = false,
}
lsp.setup()

vim.notify = function(msg, ...)
  if msg:match('offset_encodings') then
    return
  end
  notify(msg, ...)
end
