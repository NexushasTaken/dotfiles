function map(mode, lhs, rhs, opts)
  opts = opts or { noremap=true }
  vim.keymap.set(mode, lhs, rhs, opts)
end
vim.g.mapleader = ' '

map('n', '<leader>q', ':qa!<cr>')
map('n', 'sq', ':q!<cr>')
map('n', 'saq', ':wqa!<cr>')
map('n', 'sw', ':w!<cr>')
map('n', 'saw', ':wa!<cr>')
map('n', 'ss', ':split<cr>')
map('n', 'sv', ':vsplit<cr>')
map('n', 'st', ':tabnew<cr>')
map('n', 'sh', ':wincmd h<cr>')
map('n', 'sk', ':wincmd k<cr>')
map('n', 'sj', ':wincmd j<cr>')
map('n', 'sl', ':wincmd l<cr>')
map('n', 'st', ':tabnew ')

map('n', '<m-L>', ':vertical resize +1<cr>')
map('n', '<m-H>', ':vertical resize -1<cr>')
map('n', '<m-K>', ':resize +1<cr>')
map('n', '<m-J>', ':resize -1<cr>')

map('n', 's<right>', ':vertical resize +1<cr>')
map('n', 's<left>', ':vertical resize -1<cr>')
map('n', 's<up>', ':resize +1<cr>')
map('n', 's<down>', ':resize -1<cr>')

map('n', 'sp', ':tabp<cr>')
map('n', 'sn', ':tabn<cr>')
map('n', '<leader>u', vim.cmd.UndotreeToggle)
map('n', '<leader>e', vim.cmd.Explore)
map('n', '<leader>n', vim.cmd.NvimTreeFocus)
map('n', '<leader>l', ':nohl<cr>')

-- For termux only {
map('n', '<leader>p', '<esc>"+p')
map('n', '<leader>yy', '<esc>"+yy')
map('v', '<leader>y', '"+y')
-- }

map('n', "<leader>ff", ":Telescope find_files<cr>")
map('n', "<leader>fg", ":Telescope live_grep<cr>")
map('n', "<leader>fb", ":Telescope buffers<cr>")
map('n', "<leader>fh", ":Telescope help_tags<cr>")
