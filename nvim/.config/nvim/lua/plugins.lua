-- This file can be loaded by calling `require('plugins')` from your init.lua

return require('packer').startup(function(use)
	  -- Packer can manage itself
	  use 'wbthomason/packer.nvim'
	  use {                                              -- filesystem navigation
	    'kyazdani42/nvim-tree.lua',
	    requires = 'kyazdani42/nvim-web-devicons'        -- filesystem icons
	  }
	  use 'windwp/nvim-autopairs'
	  use {
	    'williamboman/mason.nvim',
	    'williamboman/mason-lspconfig.nvim',
	    'neovim/nvim-lspconfig',
	  }
	  use 'simrat39/rust-tools.nvim'
	  -- Completion framework:
	  use 'hrsh7th/nvim-cmp'

	  -- LSP completion source:
	  use 'hrsh7th/cmp-nvim-lsp'

	  -- Useful completion sources:
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/vim-vsnip'

    -- Theme
    use { 'rose-pine/neovim', as = 'rose-pine' }
end)
