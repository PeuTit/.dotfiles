local map = require('crozes-hermitage.utils').map

return {
  -- Git signs in the gutter (left to the numbers)
  {
    'lewis6991/gitsigns.nvim',
    opts = {},
    config = function()
      map('n', '<leader>tb', ':Gitsigns toggle_current_line_blame<CR>',
        { desc = '[T]oggle Git [B]lame' })
    end
  },
}
