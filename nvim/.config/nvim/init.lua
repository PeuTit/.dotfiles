-- Set leader key to <Space>
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("plugins")

-- Set terminal color
vim.g.termguicolors = true

-- Disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set number
vim.opt.number = true

-- Tab set to two spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- Global options
vim.opt_global.clipboard = "unnamed"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- empty setup using defaults
require("mason").setup()
require("mason-lspconfig").setup()
require("fidget").setup()
require("which-key").setup()
require("gitsigns").setup()
require("lualine").setup {
  options = {
    theme = 'auto',
  }
}
require("Comment").setup()
require("nvim-autopairs").setup()

-- telescope configuration
require("telescope").setup({
  defaults = {
    mappings = {
      -- remove scrolling up/down in preview when in 'insert mode'
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      }
    },
    initial_mode = "normal",
  }
})

require("telescope").load_extension("fzy_native")

require('nvim-treesitter.configs').setup {
  modules = {},
  sync_install = false,
  ignore_install = {},
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'lua', 'rust', 'vimdoc', 'vim', 'scala' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Telescope
local telescope_builtin = require('telescope.builtin')

map('n', '<leader>?', telescope_builtin.oldfiles, { desc = '[?] Find recently opened files' })
map('n', '<leader><space>', telescope_builtin.buffers, { desc = '[ ] Find existing buffers' })
map('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  telescope_builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
    initial_mode = "insert",
  })
end, { desc = '[/] Fuzzily search in current buffer' })

map('n', '<leader>sf', telescope_builtin.find_files, { desc = '[S]earch [F]iles' })
map('n', '<leader>sh', telescope_builtin.help_tags, { desc = '[S]earch [H]elp' })
map('n', '<leader>sw', telescope_builtin.grep_string, { desc = '[S]earch current [W]ord' })
map('n', '<leader>lg', telescope_builtin.live_grep, { desc = '[L]ive [G]rep' })
map('n', '<leader>sd', telescope_builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
map('n', '<leader>gh', telescope_builtin.git_commits, { desc = '[G]it [H]istory' })

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
map('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- LSP settings.
--  This function gets run when a LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', telescope_builtin.lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', telescope_builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', telescope_builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Format code
map('n', '<leader>fm', ':Format<cr>', { desc = '[F]or[M]at' })

-- Remove trailing whitespace
map('n', '<leader>tw', [[:%s/\s\+$//e<cr>]], { desc = '[T]railing [W]hitespace' })

-- Close all buffers except current
map('n', '<leader>cba', [[:%bd|e#<cr>]], { desc = '[C]lose [B]uffers [A]ll' })

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

require("neodev").setup()

-- Move between vertically splited window
map('n', '<A-,>', '<Cmd>:wincmd h<CR>', opts)
map('n', '<A-.>', '<Cmd>:wincmd l<CR>', opts)

-- Make Space useless in normal mode
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- Completion Plugin Setup
local cmp = require('cmp')
local luasnip = require('luasnip')

luasnip.config.setup {}

cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    })
  },
  -- Installed sources:
  sources = {
    { name = 'path' },                                       -- file paths
    { name = 'nvim_lsp',               keyword_length = 3 }, -- from language server
    { name = 'nvim_lsp_signature_help' },                    -- display function signatures with current parameter emphasized
    { name = 'buffer',                 keyword_length = 2 }, -- source current buffer
    { name = 'vsnip',                  keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
    { name = 'calc' },                                       -- source for math calculation
    { name = 'luasnip' },
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    fields = { 'menu', 'abbr', 'kind' },
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = 'λ',
        vsnip = '⋗',
        buffer = 'Ω',
        path = '🖫',
      }
      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
  view = {
    entries = "native",
  }
})

-- metals configuration
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })

local metals_config = require("metals").bare_config()
metals_config.init_options.statusBarProvider = "on"

metals_config.on_attach = function(client, bufnr)
  on_attach(client, bufnr)
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})



vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.scala.html" },
  command = "set filetype=scala",
  group = nvim_metals_group,
})

--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert' }
vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.api.nvim_set_option('updatetime', 300)

-- Set Theme: default to main
local rose_pine = require('rose-pine')

vim.cmd('colorscheme rose-pine')

map('n', '<leader>ol', function()
  rose_pine.setup({
    variant = 'dawn',
  })
  vim.cmd('colorscheme rose-pine')
end, { desc = '[O]n [L]ight' })

map('n', '<leader>od', function()
  rose_pine.setup({
    variant = 'main',
  })
  vim.cmd('colorscheme rose-pine')
end, { desc = '[O]n [D]ark' })

require("indent_blankline").setup {
  show_current_context = true,
  show_current_context_start = true,
}

require("octo").setup()
