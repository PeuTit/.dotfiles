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
      picker = { enabled = true },
    },
    keys = {
      -- Top Pickers & Explorer
      map('n', '<leader><space>', function() Snacks.picker.buffers() end, { desc = 'Buffers' }),
      map('n', '<leader>sf', function() Snacks.picker.files() end, { desc = 'Find Files' }),
      map('n', "<leader>/", function() Snacks.picker.lines() end, { desc = "Buffer Lines" }),
      map('n', '<leader>lg', function() Snacks.picker.grep() end, { desc = 'Grep' }),
      map('n', '<leader>sb', function() Snacks.picker.grep_buffers() end, { desc = 'Grep Open Buffers' }),
      map('n', '<leader>rs', function() Snacks.picker.resume() end, { desc = 'Resume' }),

      map('n', '<leader>ff', function() Snacks.picker.smart() end, { desc = 'Smart Find Files' }),
      map('n', '<leader>:', function() Snacks.picker.command_history() end, { desc = 'Command History' }),
      map('n', '<leader>sC', function() Snacks.picker.commands() end, { desc = 'Commands' }),
      map('n', '<leader>s"', function() Snacks.picker.registers() end, { desc = 'Registers' }),
      map('n', '<leader>s/', function() Snacks.picker.search_history() end, { desc = 'Search History' }),
      map('n', '<leader>sa', function() Snacks.picker.autocmds() end, { desc = 'Autocmds' }),

      map('n', '<leader>sd', function() Snacks.picker.diagnostics() end, { desc = 'Diagnostics' }),
      map('n', '<leader>sD', function() Snacks.picker.diagnostics_buffer() end, { desc = 'Buffer Diagnostics' }),

      map('n', '<leader>sh', function() Snacks.picker.help() end, { desc = 'Help Pages' }),
      map('n', '<leader>sH', function() Snacks.picker.highlights() end, { desc = 'Highlights' }),
      map('n', '<leader>si', function() Snacks.picker.icons() end, { desc = 'Icons' }),
      map('n', '<leader>sj', function() Snacks.picker.jumps() end, { desc = 'Jumps' }),
      map('n', '<leader>sk', function() Snacks.picker.keymaps() end, { desc = 'Keymaps' }),
      map('n', '<leader>sl', function() Snacks.picker.loclist() end, { desc = 'Location List' }),
      map('n', '<leader>sm', function() Snacks.picker.marks() end, { desc = 'Marks' }),
      map('n', '<leadfr>sM', function() Snacks.picker.man() end, { desc = 'Man Pages' }),
      map('n', '<leader>sp', function() Snacks.picker.lazy() end, { desc = 'Search for Plugin Spec' }),
      map('n', '<leader>sq', function() Snacks.picker.qflist() end, { desc = 'Quickfix List' }),
      map('n', '<leader>su', function() Snacks.picker.undo() end, { desc = 'Undo History' }),
      map('n', '<leader>uC', function() Snacks.picker.colorschemes() end, { desc = 'Colorschemes' }),

      -- Buffers
      map('n', '<leader>cba', function() Snacks.bufdelete.all() end, { desc = '[C]lose [B]uffers [A]ll' }),
      map('n', '<leader>cbo', function() Snacks.bufdelete.other() end, { desc = '[C]lose [B]uffers [O]ne' }),

      -- scratch
      map('n', "<leader>.", function() Snacks.scratch() end, { desc = "Toggle Scratch Buffer" }),
      map('n', "<leader>S", function() Snacks.scratch.select() end, { desc = "Select Scratch Buffer" }),
    },
  },
}
