local map = require('crozes-hermitage.utils').map

local lsp_group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })

--  This function gets run when a LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    map('n', keys, func, { buffer = bufnr, desc = desc })
  end


  nmap('gd', vim.lsp.buf.definition, '[G]o to [D]efinition')
  nmap('<leader>fm', vim.lsp.buf.format, '[F]or[M]at current buffer with LSP')
  nmap('<leader>cl', vim.lsp.codelens.run, '[C]ode [L]ens Run')

  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  vim.lsp.inlay_hint.enable(true)
  nmap('<leader>ih', function()
    local state = vim.lsp.inlay_hint.is_enabled({})
    print("Toggle Inlay Hint from " .. tostring(state) .. " to " .. tostring(not state))

    vim.lsp.inlay_hint.enable(not state)
  end, 'Toggle [I]nlay [H]int')

  -- Telescope
  local telescope_builtin = require('telescope.builtin')

  nmap('<leader>gd', function()
    local opts = require('telescope.themes').get_ivy()
    telescope_builtin.lsp_definitions(opts)
  end, 'Goto Definition')
  nmap('<leader>gr', telescope_builtin.lsp_references, 'References')
  nmap('<leader>gI', telescope_builtin.lsp_implementations, 'Goto Implementation')
  nmap('<leader>gt', telescope_builtin.lsp_type_definitions, 'Goto Type Definition')
  nmap('<leader>ds', telescope_builtin.lsp_document_symbols, 'Document Symbols')
  nmap('<leader>ws', telescope_builtin.lsp_workspace_symbols, 'Workspace Symbols')
  nmap('<leader>wS', telescope_builtin.lsp_dynamic_workspace_symbols, 'Dynamic Workspace Symbols')

  nmap('<leader>gi', telescope_builtin.lsp_incoming_calls, 'Incoming Calls')
  nmap('<leader>go', telescope_builtin.lsp_outgoing_calls, 'Outgoing Calls')

  -- Diagnostic
  vim.diagnostic.config({ virtual_text = true })
  nmap('gsd', vim.diagnostic.setqflist, 'Send diagnostics to quickfix list')
  map('n', '<leader>sd', telescope_builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  map('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open Floating Diagnostic Message" })

  if client.server_capabilities.documentHighlightProvider then
    -- Cursor Highlight
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = vim.lsp.buf.document_highlight,
      buffer = bufnr,
      group = lsp_group,
      desc = "Document Highlight",
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      callback = vim.lsp.buf.clear_references,
      buffer = bufnr,
      group = lsp_group,
      desc = "Clear All the References",
    })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
      callback = vim.lsp.codelens.refresh,
      buffer = bufnr,
      group = lsp_group,
    })
  end

  nmap('<leader>td', function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  end, '[T]oggle [D]iagnostics')
end

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'saghen/blink.cmp',
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      -- on_attach
      require('lspconfig').lua_ls.setup { capabilities = capabilities, on_attach = on_attach }
      require('lspconfig').rust_analyzer.setup { capabilities = capabilities, on_attach = on_attach }
      require('lspconfig').ts_ls.setup { capabilities = capabilities, on_attach = on_attach }
      require('lspconfig').bashls.setup { capabilities = capabilities, on_attach = on_attach }
      require('lspconfig').jsonls.setup { capabilities = capabilities, on_attach = on_attach }
      -- require('lspconfig').groovyls.setup {
      --   cmd = { "java", "-jar", '~/Documents/lunatech/audi/tools/groovy-language-server/build/libs/groovy-language-server-all.jar' },
      --   capabilities = capabilities,
      --   on_attach = on_attach
      -- }
    end,
  },
  -- Metals
  {
    "scalameta/nvim-metals",
    dependencies = {
      'saghen/blink.cmp',
      "nvim-lua/plenary.nvim",
    },
    ft = { "scala", "sbt", "java" },
    opts = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local metals_config = require("metals").bare_config()

      metals_config.init_options.statusBarProvider = "off"
      metals_config.on_attach = on_attach
      metals_config.capabilities = capabilities
      metals_config.settings = {
        superMethodLensesEnabled = true,
        inlayHints = {
          byNameParameters = { enable = true },
          hintsInPatternMatch = { enable = true },
          implicitArguments = { enable = true },
          implicitConversions = { enable = true },
          inferredTypes = { enable = true },
          typeParameters = { enable = true }
        },
        autoImportBuild = "all"
      }

      return metals_config
    end,
    config = function(self, metals_config)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = self.ft,
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = lsp_group,
      })
      local telescope_extension = require('telescope').extensions

      map("n", "<leader>mc", telescope_extension.metals.commands, { desc = '[M]etals [C]ommands' })
    end
  }
}
