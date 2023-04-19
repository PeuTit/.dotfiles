local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local setup = function()
  -- Tab
  map('n', '<A-,>', '<Cmd>tabprevious<CR>', opts)
  map('n', '<A-.>', '<Cmd>tabnext<CR>', opts)

  map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true})

  -- Telescope
  map('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
  map('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
  map('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = '[/] Fuzzily search in current buffer' })

  map('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
  map('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
  map('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
  map('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
  map('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

  -- Diagnostic keymaps
  map('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
  map('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
  map('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
  map('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
end

return {
  setup = setup,
}
