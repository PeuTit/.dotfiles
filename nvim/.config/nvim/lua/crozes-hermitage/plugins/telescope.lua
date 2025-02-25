local map = require('crozes-hermitage.utils').map

return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
      }
    },
    config = function()
      require('telescope').setup {
        pickers = {
          find_files = {
            theme = 'ivy'
          },
          current_buffer_fuzzy_find = {
            theme = 'ivy'
          },
        },
        extensions = {
          fzf = {},
        }
      }
      require('telescope').load_extension('fzf')
      local telescope_builtin = require('telescope.builtin')

      map('n', '<leader>sf', telescope_builtin.find_files, { desc = '[S]earch [F]iles' })
      map('n', '<leader><leader>', function()
        local opts = require('telescope.themes').get_ivy()
        telescope_builtin.buffers(opts)
      end, { desc = '[ ] Find existing buffers' })

      map('n', '<leader>/', telescope_builtin.current_buffer_fuzzy_find,
        { desc = '[/] Fuzzily search in current buffer' })
      map('n', '<leader>lg', telescope_builtin.live_grep, { desc = '[L]ive [G]rep' })

      map('n', '<leader>lm', function()
        require('crozes-hermitage.plugins.telescope.custom').live_multigrep()
      end, { desc = '[L]ive [M]ultigrep' })

      map('n', '<leader>sh', telescope_builtin.help_tags, { desc = '[S]earch [H]elp' })

      map('n', '<leader>sk', telescope_builtin.keymaps, { desc = '[S]earch [K]eymaps' })

      -- Git
      map('n', '<leader>gs', telescope_builtin.git_status, { desc = '[G]it [S]tatus' })

      -- Treesitter
      map("n", "<leader>st", telescope_builtin.treesitter, { desc = '[S]earch [T]reesitter' })

      map('n', '<leader>sr', telescope_builtin.resume, { desc = "[S]earch [R]esume" })

      map('n', '<leader>en', function()
        telescope_builtin.find_files {
          cwd = vim.fn.stdpath('config')
        }
      end, { desc = 'Search Current Config' })
      map('n', '<leader>ep', function()
        telescope_builtin.find_files {
          ---@diagnostic disable-next-line: param-type-mismatch
          cwd = vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy')
        }
      end, { desc = 'Search Current Packages' })

      -- Commands
      map('n', '<leader>sc', telescope_builtin.commands, { desc = '[S]earch [C]ommands' })
      map('n', '<leader>;', telescope_builtin.command_history, { desc = '[S]earch Command History' })

      -- Registers
      map('n', "<leader>s'", telescope_builtin.registers, { desc = '[S]earch Registers' })

      map('n', '<leader>s/', telescope_builtin.search_history, { desc = '[S]earch History' })
      map('n', '<leader>sa', telescope_builtin.autocommands, { desc = '[S]earch [A]utocommands' })

      map('n', '<leader>sH', telescope_builtin.highlights, { desc = '[S]earch Highlights' })
      map('n', '<leader>sj', telescope_builtin.jumplist, { desc = '[S]earch Jumps' })
      map('n', '<leader>sl', telescope_builtin.loclist, { desc = '[S]earch Location List' })
      map('n', '<leader>sm', telescope_builtin.marks, { desc = '[S]earch Marks' })
      map('n', '<leader>sC', telescope_builtin.colorscheme, { desc = '[S]earch Colorschemes' })
    end
  }
}
