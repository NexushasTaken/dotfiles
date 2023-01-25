local lsp = require('lsp-zero')

lsp.preset'recommended'
lsp.setup_servers{
  'clangd',
  force = true
}
lsp.setup()
