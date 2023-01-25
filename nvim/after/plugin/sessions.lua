require'sessions'.setup()
local session = require'sessions'
local dir_session = os.getenv('HOME') .. '/.local/share/nvim/sessions/'.. vim.fn.getcwd():gsub('/', '_')
vim.keymap.set('n', '<leader>ss', function()
  session.save(dir_session)
  print'Session saved'
end)
vim.keymap.set('n', '<leader>sl', function()
  session.load(dir_session)
  print'Session loaded'
end)
