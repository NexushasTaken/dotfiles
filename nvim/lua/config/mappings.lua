local opts = {
  silent  = true,
  noremap = true,
}
vim.g.mapleader = ' '

local function map(mode, key, cmd)
  vim.keymap.set(mode, key, cmd, opts)
end

map('n', '<s-tab>', ':tabp<CR>')
map('n', '<tab>', ':tabn<CR>')
map('n', '<a-<>', ':-tabmove<CR>')
map('n', '<a->>', ':+tabmove<CR>')
map('n', '<a-c>', ':q!<CR>')
map('t', '<esc>', '<c-\\><c-n>')
map('n', 'ss', ':split<cr>')
map('n', 'sv', ':vsplit<cr>')
map('n', 'st', ':tabnew ')

map('n', '<leader>l', ':nohl<cr>')
map('n', '<leader>n', ':NvimTreeFocus<cr>')
map('n', '<leader>g', ':LazyGit<cr>')

-- Copy
map('v', '<leader>y', '"+y')
map('n', '<leader>yy', '"+yy')

-- Paste
map('n', '<leader>p', '"+p')
map('v', '<leader>p', '"+p')

-- Window, buffer, panel
map('n', 'sh', ':wincmd h<cr>')
map('n', 'sk', ':wincmd k<cr>')
map('n', 'sj', ':wincmd j<cr>')
map('n', 'sl', ':wincmd l<cr>')

-- Resizing {
map('n', '<a-s-h>', ':vertical resize +1<cr>')
map('n', '<a-s-l>', ':vertical resize -1<cr>')
map('n', '<a-s-k>', ':resize +1<cr>')
map('n', '<a-s-j>', ':resize -1<cr>')
-- }

-- File actions {
map('n', '<leader>q', ':qa!<cr>')
map('n', '<leader>sq', ':wqa!<cr>')
map('n', '<leader>sw', ':w!<cr>')
map('n', '<leader>sa', ':wa!<cr>')
-- }

-- Saving session {
local session = require'sessions'
local dir_session = os.getenv('HOME') .. '/.config/nvim/.sessions/'.. vim.fn.getcwd():gsub('/', '_')
map('n', '<leader>ss', function()
  session.save(dir_session)
end)
map('n', '<leader>sl', function()
  session.load(dir_session)
end)
-- }

-- Hop mappings {
local hop_trig = '<leader>h'

local function hop_map(key, cmd)
  map('n', hop_trig .. key, ':'..cmd)
end

hop_map("w", "HopWord<cr>")
hop_map("p", "HopPattern ")
hop_map("l", "HopVertical<cr>")
hop_map("e", "HopAnywhere<cr>")
-- }

-- Telescope mappings {
map('n', "<leader>ff", "<cmd>Telescope find_files<cr>")
map('n', "<leader>fg", "<cmd>Telescope live_grep<cr>")
map('n', "<leader>fb", "<cmd>Telescope buffers<cr>")
map('n', "<leader>fh", "<cmd>Telescope help_tags<cr>")
-- }
