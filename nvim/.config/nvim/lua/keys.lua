local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Tree
map('n', 'n', '<Cmd>NvimTreeToggle<CR>', {})

-- Bar
map('n', '<A-,>', '<Cmd>tabprevious<CR>', opts)
map('n', '<A-.>', '<Cmd>tabnext<CR>', opts)

