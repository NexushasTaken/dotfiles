local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>ds', vim.diagnostic.setloclist, opts)
vim.keymap.set('n', '<leader>d[', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<leader>d]', vim.diagnostic.goto_next, opts)

local on_attach = function(_, bufnr)
  -- For some reason some language server tabstop and shiftwidth is set to 4
  vim.opt.tabstop    = 2
  vim.opt.shiftwidth = 2
  vim.opt.expandtab  = true
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = {
    noremap = true,
    silent = true,
    buffer = bufnr,
  }
  vim.keymap.set('n', '<leader>bD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', '<leader>bd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<leader>bh', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<leader>bi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<leader>bs', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>bt', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>br', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ba', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>b<s-r>', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>bf', function() vim.lsp.buf.format {
      async = true,
    }
  end, bufopts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local function setup(server)
  local config = require('config.server_configs.' .. server).default_config
  config.on_attach = on_attach
  config.capabilities = capabilities
  require('lspconfig')[server].setup(config)
end

setup'html'
setup'cssls'
setup'cmake'
setup'jdtls'
setup'vimls'
setup'jsonls'
setup'bashls'
setup'awk_ls'
setup'pyright'
setup'omnisharp'
setup'sumneko_lua'
setup'gdscript'

require'rust-tools'.setup{
  server = { on_attach = on_attach }
}
require'clangd_extensions'.setup{
  server = { on_attach = on_attach },
}
require'typescript'.setup{
  server = { on_attach = on_attach },
}
