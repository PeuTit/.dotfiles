return {
  'nvim-treesitter/nvim-treesitter',
  config = function()
    local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
    ts_update()

    require('nvim-treesitter.configs').setup {
      modules = {},
      sync_install = false,
      ignore_install = {},
      ensure_installed = { 'c', 'lua', 'rust', 'vimdoc', 'vim', 'scala' },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    }
  end
}
