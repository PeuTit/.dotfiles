local map = require('crozes-hermitage.utils').map

-- Set terminal colour
vim.g.termguicolors = true

-- Set number
vim.opt.number = true
vim.opt.relativenumber = true

-- Tab set to two spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- Global options
vim.opt_global.clipboard = "unnamed"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Spell check
vim.opt.spell = true
vim.opt.spelllang = "en_gb"

-- Make Space useless in normal mode
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Save file
map('n', '<leader>fs', ':w<cr>', { desc = '[F]ile [S]ave' })

-- Remove trailing white space
map('n', '<leader>tw', [[:%s/\s\+$//e<cr>]], { desc = '[T]railing [W]hitespace' })

-- Open Quick Fix
map('n', '<leader>qo', ':copen<cr>', { desc = '[Q]uick Fix [O]pen' })

-- Close Quick Fix
map('n', '<leader>qc', ':cclose<cr>', { desc = '[Q]uick Fix [C]lose' })

-- Lua goodies
map('n', '<leader><leader>x', '<cmd>source %<cr>', { desc = 'Source the current file' })
map('n', '<leader>x', ':.lua <cr>', { desc = 'Execute the  current line' })
map('v', '<leader>x', ':lua <cr>', { desc = 'Execute the  current line' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
