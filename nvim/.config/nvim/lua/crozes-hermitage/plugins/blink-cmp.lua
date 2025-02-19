return {
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

      cmdline = {
        enabled = false
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
  },
}
