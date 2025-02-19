local map = require('crozes-hermitage.utils').map

-- Set terminal colour
vim.g.termguicolors = true

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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

-- Save file
map('n', '<leader>fs', ':w<cr>', { desc = '[F]ile [S]ave' })

-- Diagnostic key maps
map('n', '<leader>pd', vim.diagnostic.goto_prev, { desc = "[P]revious [D]iagnostic" })
map('n', '<leader>nd', vim.diagnostic.goto_next, { desc = "[N]ext [D]iagnostic" })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })

-- Format code
map('n', '<leader>fm', ':Format<cr>', { desc = '[F]or[M]at' })

-- Remove trailing white space
map('n', '<leader>tw', [[:%s/\s\+$//e<cr>]], { desc = '[T]railing [W]hitespace' })

-- List all conflicts to quick fix
map('n', '<leader>glc', ':GitConflictListQf<cr>', { desc = '[G]it [L]ist [C]onflict' })

-- Open Quick Fix
map('n', '<leader>qo', ':copen<cr>', { desc = '[Q]uick Fix [O]pen' })

-- Close Quick Fix
map('n', '<leader>qc', ':cclose<cr>', { desc = '[Q]uick Fix [C]lose' })

-- Make Space useless in normal mode
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
