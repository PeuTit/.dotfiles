local map = require('crozes-hermitage.utils').map

---@diagnostic disable: undefined-doc-name
return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      dim = { enabled = true },
      quickfile = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      rename = { enabled = true },
      scratch = { enabled = true },
      toggle = { enabled = true },
      zen = { enabled = true },
    },
    keys = {
      -- Buffers
      map('n', '<leader>cba', function() Snacks.bufdelete.all() end, { desc = '[C]lose [B]uffers [A]ll' }),
      map('n', '<leader>cbo', function() Snacks.bufdelete.other() end, { desc = '[C]lose [B]uffers [O]ne' }),

      -- scratch
      map('n', "<leader>.", function() Snacks.scratch() end, { desc = "Toggle Scratch Buffer" }),
      map('n', "<leader>S", function() Snacks.scratch.select() end, { desc = "Select Scratch Buffer" }),
    },
  },
}
