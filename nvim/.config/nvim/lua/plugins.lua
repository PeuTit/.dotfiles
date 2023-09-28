-- This file can be loaded by calling `require('plugins')` from your init.lua

return require('lazy').setup({
  -- LSP related plugins
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'neovim/nvim-lspconfig' },
  {
    'j-hui/fidget.nvim',
    tag = 'legacy',
  },

  -- Completion framework:
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      {
        'hrsh7th/cmp-nvim-lsp',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
      }
    }
  },

  -- Lua configuration for neovim
  { 'folke/neodev.nvim' },

  -- Show pending keybinds
  { 'folke/which-key.nvim' },

  -- Git signs in the gutter (left to the numbers)
  { 'lewis6991/gitsigns.nvim' },

  -- Theme
  { 'rose-pine/neovim',       as = 'rose-pine' },

  -- Statusbar
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },

  -- Commenting code
  { 'numToStr/Comment.nvim' },

  -- Fuzzy finding files and much more
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },

      -- Fuzzy finder algorithm with local dependencie
      -- { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
      { 'nvim-telescope/telescope-fzy-native.nvim' }
    }
  },

  -- Highlight, edit and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  },

  { 'windwp/nvim-autopairs' },

  -- Metals & Plenary
  {
    'scalameta/nvim-metals',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  -- Indent Rainbow
  { "lukas-reineke/indent-blankline.nvim" },

  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    }
  },

  {
    'akinsho/git-conflict.nvim',
    version = "*",
    config = true
  }
})
