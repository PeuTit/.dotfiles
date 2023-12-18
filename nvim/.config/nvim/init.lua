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

-- Set terminal colour
vim.g.termguicolors = true

-- Disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set number
vim.opt.number = true
vim.opt.relativenumber = true

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

-- Spell check
vim.opt.spell = true
vim.opt.spelllang = "en_gb"

local function metals_status()
  return vim.g["metals_status"] or ""
end

-- empty setup using defaults
require("mason").setup()
require("mason-lspconfig").setup()
require("fidget").setup()
require("which-key").setup()
require("gitsigns").setup()
require("lualine").setup {
  options = {
    theme = 'auto',
  },
   sections = {
    lualine_c = {'filename', metals_status},
  },
}
require("Comment").setup()
require("nvim-autopairs").setup()

-- Telescope actions
local actions = require("telescope.actions")
-- telescope configuration
require("telescope").setup({
  defaults = {
    mappings = {
      -- remove scrolling up/down in preview when in 'insert mode'
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
      n = {
        ["f"] = actions.send_to_qflist,
      },
    },
    initial_mode = "normal",
    layout_strategy = "vertical"
  }
})

require("telescope").load_extension("fzy_native")

require('nvim-treesitter.configs').setup {
  modules = {},
  sync_install = false,
  ignore_install = {},
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'lua', 'rust', 'vimdoc', 'vim', 'scala' },

  -- Auto install languages that are not installed. Defaults to false (but you can change for yourself!)
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
      set_jumps = true, -- whether to set jumps in the jump list
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

-- Don't overwrite paste register
map('n', '<leader>p', '"_dP', { desc = 'Alternate Paste Register'})

-- Telescope
local telescope_builtin = require('telescope.builtin')
local telescope_extension = require('telescope').extensions

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
map('n', '<leader>sd', telescope_builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })

map('n', '<leader>sh', function()
  telescope_builtin.help_tags {
    initial_mode = "insert"
  }
end, { desc = '[S]earch [H]elp' })

map('n', '<leader>lg', function()
  telescope_builtin.live_grep {
    initial_mode = "insert"
  }
end, { desc = '[L]ive [G]rep' })

map('n', '<leader>sc', function()
  telescope_builtin.commands { initial_mode = "insert" }
end, { desc = '[S]earch [C]ommands' })

map('n', '<leader>sk', function()
  telescope_builtin.keymaps { initial_mode = "insert" }
end, { desc = '[S]earch [K]eymaps' })

-- Telescope Git
map('n', '<leader>gh', telescope_builtin.git_commits, { desc = '[G]it [H]istory' })
map('n', '<leader>gs', telescope_builtin.git_status, { desc = '[G]it [S]tatus' })

-- Telescope Metals
map("n", "<leader>mc", function()
  telescope_extension.metals.commands {
    initial_mode = "insert"
  }
end, { desc = '[M]etals [C]ommands' })

-- Telescope Treesitter
map("n", "<leader>ts", telescope_builtin.treesitter, { desc = '[T]ree[S]itter' })

-- Diagnostic key maps
map('n', '<leader>pd', vim.diagnostic.goto_prev, { desc = "[P]revious [D]iagnostic" })
map('n', '<leader>nd', vim.diagnostic.goto_next, { desc = "[N]ext [D]iagnostic" })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })

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

  nmap('gd', telescope_builtin.lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', telescope_builtin.lsp_references, '[G]oto [R]eferences')
  nmap('gi', telescope_builtin.lsp_implementations, '[G]oto [I]mplementations')
  nmap('<leader>gt', telescope_builtin.lsp_type_definitions, '[G]oto [T]ype [D]efinitions')
  nmap('<leader>ds', telescope_builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', telescope_builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
  nmap('<leader>ic', telescope_builtin.lsp_incoming_calls, '[I]ncoming [C]alls')
  nmap('<leader>oc', telescope_builtin.lsp_outgoing_calls, '[O]utgoing [C]alls')

  -- See `:help K` for why this key map
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

-- Remove trailing white space
map('n', '<leader>tw', [[:%s/\s\+$//e<cr>]], { desc = '[T]railing [W]hitespace' })

-- Close all buffers except current
map('n', '<leader>cba', [[:%bd|e#|bd#<cr>'"]], { desc = '[C]lose [B]uffers [A]ll' })

-- List all conflicts to quick fix
map('n', '<leader>glc', ':GitConflictListQf<cr>', { desc = '[G]it [L]ist [C]onflict' })

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server configuration. You must look up that documentation yourself.
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
map({ 'n', 't' }, '<A-h>', '<Cmd>NavigatorLeft<CR>', opts)
map({ 'n', 't' }, '<A-l>', '<Cmd>NavigatorRight<CR>', opts)
map({ 'n', 't' }, '<A-k>', '<Cmd>NavigatorUp<CR>', opts)
map({ 'n', 't' }, '<A-j>', '<Cmd>NavigatorDown<CR>', opts)
map({ 'n', 't' }, '<A-space>', '<Cmd>NavigatorPrevious<CR>', opts)

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

local nvim_lsp = require('lspconfig')

mason_lspconfig.setup_handlers {
  function(server_name)
    nvim_lsp[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- Typescript & Deno configuration
nvim_lsp.denols.setup {
  on_attach = on_attach,
  root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
}

nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  root_dir = nvim_lsp.util.root_pattern("package.json"),
  single_file_support = false
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
    { name = 'luasnip' },
    { name = 'nvim_lsp',               keyword_length = 3 }, -- from language server
    { name = 'nvim_lsp_signature_help' },                    -- display function signatures with current parameter emphasized
    { name = 'buffer',                 keyword_length = 2 }, -- source current buffer
    { name = 'path' },                                       -- file paths
    { name = 'calc' },                                       -- source for maths calculation
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

-- TODO: uncomment when tree view will be fixed
--[[ metals_config.tvp = {
  icons = {
    enable = true,
  }
} ]]

metals_config.settings = {
  showImplicitArguments = true,
  showImplicitConversionsAndClasses = true,
  showInferredType = true
}

metals_config.capabilities = capabilities

metals_config.on_attach = function(client, bufnr)
  on_attach(client, bufnr)

  map("v", "K", require("metals").type_of_range)

  map("n", "<leader>hs", function()
    require("metals").hover_worksheet({ border = "single" })
  end, { desc = '[H]over work[S]heet' })

  -- TODO: Figure out why the tree view is opened anytime a file is loaded
  -- map("n", "<leader>tt", require("metals.tvp").toggle_tree_view, { desc = '[T]oggle [T]ree' })

  -- map("n", "<leader>tr", require("metals.tvp").reveal_in_tree { desc = '[T]ree [R]eveal' })

  map("n", "<leader>mts", function()
    require("metals").toggle_setting("showImplicitArguments")
  end, { desc = '[M]etals [T]oggle [S]howImplicitArguments' })

  -- A lot of the servers I use won't support document_highlight or code lens,
  -- so we just use them in Metals
  vim.api.nvim_create_autocmd("CursorHold", {
    callback = vim.lsp.buf.document_highlight,
    buffer = bufnr,
    group = nvim_metals_group,
  })
  vim.api.nvim_create_autocmd("CursorMoved", {
    callback = function()
      vim.lsp.buf.clear_references()
    end,
    buffer = bufnr,
    group = nvim_metals_group,
  })
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
    callback = vim.lsp.codelens.refresh,
    buffer = bufnr,
    group = nvim_metals_group,
  })
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
-- menuone: pop-up even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert' }
vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.api.nvim_set_option('updatetime', 300)

-- Set Theme: default to main
local catppuccin = require('catppuccin')

vim.cmd('colorscheme catppuccin')

local function set_colour_scheme(flavour)
  catppuccin.setup({
    flavour = flavour,
  })
  vim.cmd('colorscheme catppuccin')
end

map('n', '<leader>ol', function()
  set_colour_scheme("latte")
  vim.cmd.colorscheme "catppuccin"
end, { desc = '[O]n [L]ight' })

map('n', '<leader>od', function()
  set_colour_scheme("mocha")
  vim.cmd.colorscheme "catppuccin"
end, { desc = '[O]n [D]ark' })

local highlight = {
  "RainbowRed",
  "RainbowYellow",
  "RainbowBlue",
  "RainbowOrange",
  "RainbowGreen",
  "RainbowViolet",
  "RainbowCyan",
}
local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colour scheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
  vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
  vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
  vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
  vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
  vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
  vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

require("ibl").setup({ scope = { highlight = highlight } })

require("Navigator").setup({ disable_on_zoom = true, mux = "auto" })
