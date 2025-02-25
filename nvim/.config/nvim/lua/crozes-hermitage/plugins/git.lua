local map = require('crozes-hermitage.utils').map
return {
  -- Git signs in the gutter (left to the numbers)
  { 'lewis6991/gitsigns.nvim', opts = {} },
  -- Git conflict
  {
    'akinsho/git-conflict.nvim',
    version = "*",
    opts = {},
    config = function()
      map('n', '<leader>glc', ':GitConflictListQf<cr>', { desc = '[G]it [L]ist [C]onflict' })
    end
  },
}
