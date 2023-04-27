-- This file can be loaded by calling `require('plugins')` from your init.lua

return require('packer').startup(function(use)
	  -- Packer can manage itself
	  use 'wbthomason/packer.nvim'

    -- LSP related plugins
	  use {
	    'williamboman/mason.nvim',
	    'williamboman/mason-lspconfig.nvim',
	    'neovim/nvim-lspconfig',
	  }
    use 'j-hui/fidget.nvim'

	  -- Completion framework:
	  use {
      'hrsh7th/nvim-cmp',
      requires = {
        {
          'hrsh7th/cmp-nvim-lsp',
          'L3MON4D3/LuaSnip',
          'saadparwaiz1/cmp_luasnip',
        }
      }
    }

    -- Lua configuration for neovim
    use 'folke/neodev.nvim'

    -- Show pending keybinds
    use 'folke/which-key.nvim'

    -- Git signs in the gutter (left to the numbers)
    use 'lewis6991/gitsigns.nvim'

    -- Theme
    use { 'rose-pine/neovim', as = 'rose-pine' }

    -- Statusbar
    use {
      'nvim-lualine/lualine.nvim',
      requires = { { 'nvim-tree/nvim-web-devicons' } }
    }

    -- Commenting code
    use 'numToStr/Comment.nvim'

    -- Fuzzy finding files and much more
    use {
      'nvim-telescope/telescope.nvim',
      requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- Fuzzy finder algorithm with local dependencies
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- Highlight, edit and navigate code
    use {
      'nvim-treesitter/nvim-treesitter',
      run = function()
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
      end,
    }

	  use 'windwp/nvim-autopairs'

    -- Metals & Plenary
    use { 'scalameta/nvim-metals', requires = { 'nvim-lua/plenary.nvim' }}
end)
