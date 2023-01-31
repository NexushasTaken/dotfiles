local notify = vim.notify
local lsp = require('lsp-zero')

lsp.preset'recommended'
lsp.setup_servers{
  'clangd',
}
lsp.setup()

vim.notify = function(msg, ...)
  if msg:match('offset_encodings') then
    return
  end
  notify(msg, ...)
end
