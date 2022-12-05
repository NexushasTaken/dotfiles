local cmp = require('cmp')
local luasnip = require('luasnip')
local fn = vim.fn

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local cmp_kinds = {
  Text          = '  ',
  Method        = '  ',
  Function      = '  ',
  Constructor   = '  ',
  Field         = '  ',
  Variable      = '  ',
  Class         = '  ',
  Interface     = '  ',
  Module        = '  ',
  Property      = '  ',
  Unit          = '  ',
  Value         = '  ',
  Enum          = '  ',
  Keyword       = '  ',
  Snippet       = '  ',
  Color         = '  ',
  File          = '  ',
  Reference     = '  ',
  Folder        = '  ',
  EnumMember    = '  ',
  Constant      = '  ',
  Struct        = '  ',
  Event         = '  ',
  Operator      = '  ',
  TypeParameter = '  ',
}

require'luasnip.loaders.from_vscode'.lazy_load{
  paths = {
    fn.stdpath('config') .. '/snips',
  }
}

local entry_filter = function(entry, _)
  return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
end
cmp.setup{
  formatting = {
    fields = { 'abbr', 'kind' },
    format = function(_, vim_item)
      vim_item.kind = (cmp_kinds[vim_item.kind] .. vim_item.kind) or ''
      return vim_item
    end,
  },
  snippet = {
    expand = function(args) require('luasnip').lsp_expand(args.body) end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.scroll_docs(-4),
    ['<C-n>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = {
    { name = 'nvim_lsp', entry_filter = entry_filter },
    { name = 'luasnip',  entry_filter = entry_filter },
    { name = 'path' },
  }
}
