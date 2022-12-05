require'nvim-tree'.setup {
  sort_by = 'extension',
  hijack_cursor = true,
  hijack_netrw = true,
  open_on_tab = false,
  reload_on_bufenter = true,
  view = {
    number = true,
    relativenumber = true,
    preserve_window_proportions = true,
    float = {
      enable = false,
      open_win_config = {
        relative = 'cursor',
        height = 23,
      },
    },
  },
  renderer = {
    add_trailing = true,
    group_empty = true,
    highlight_git = true,
    full_name = false,
    indent_width = 2,
    indent_markers = {
      enable = true,
      icons = {
        corner = "╰",
        bottom = "─",
      },
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  filters = {
    dotfiles = true,
    custom = { '\\.sw.$' },
  },
  actions = {
    change_dir = {
      enable = true,
    },
    open_file = {
      quit_on_open = true,
    },
  },
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  git = {
    ignore = true,
  },
}
--local nt_api = require'nvim-tree.api'
--nt_api.events.subscribe(nt_api.events.Event.TreeOpen, function()
--  nt_api.tree.change_root(vim.opt.directory._value)
--end)
