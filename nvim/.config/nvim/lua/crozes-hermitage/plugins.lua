-- This file can be loaded by calling `require('plugins')` from your init.lua

return require('lazy').setup({
  -- Snacks
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
      zen = { enabled = true }
    },
  },

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
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = 'rafamadriz/friendly-snippets',
    version = '*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = 'enter' },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      completion = {
        keyword = {
          range = 'prefix'
        },
        trigger = {
          show_on_trigger_character = true
        },
        list = {
          selection = { preselect = true, auto_insert = true }
        },
        documentation = {
          auto_show = true
        }
      }
    },

    -- opts_extend = { "sources.default" }
  },

  -- Lua configuration for neovim
  { 'folke/neodev.nvim' },

  -- Show pending keybinds
  { 'folke/which-key.nvim' },

  -- Git signs in the gutter (left to the numbers)
  { 'lewis6991/gitsigns.nvim' },

  -- Theme
  {
    'rose-pine/neovim',
    name = 'rose-pine'
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000
  },

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
      { 'nvim-telescope/telescope-fzy-native.nvim' }
    },
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
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

  {
    'akinsho/git-conflict.nvim',
    version = "*",
    config = true
  },

  { 'tpope/vim-fugitive' },

  { 'numToStr/navigator.nvim' },

  { 'mfussenegger/nvim-dap' },

  { 'echasnovski/mini.surround', version = '*' },

  { 'hat0uma/csvview.nvim' }
})
