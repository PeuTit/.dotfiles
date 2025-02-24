local map = require('crozes-hermitage.utils').map

--  This function gets run when a LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    map('n', keys, func, { buffer = bufnr, desc = desc })
  end


  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  nmap('<leader>gr', vim.lsp.buf.references, 'References')
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

  nmap('gd', telescope_builtin.lsp_definitions, 'Goto Definition')
  nmap('gr', telescope_builtin.lsp_references, 'References')
  nmap('gI', telescope_builtin.lsp_implementations, 'Goto Implementation')
  nmap('<leader>gt', telescope_builtin.lsp_type_definitions, 'Goto Type Definition')
  nmap('<leader>ds', telescope_builtin.lsp_document_symbols, 'Document Symbols')
  nmap('<leader>ws', telescope_builtin.lsp_workspace_symbols, 'Workspace Symbols')
  nmap('<leader>wS', telescope_builtin.lsp_dynamic_workspace_symbols, 'Dynamic Workspace Symbols')

  nmap('<leader>gi', telescope_builtin.lsp_incoming_calls, 'Incoming Calls')
  nmap('<leader>go', telescope_builtin.lsp_outgoing_calls, 'Outgoing Calls')

  -- Diagnostic
  map('n', '<leader>sd', telescope_builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  map('n', '<leader>pd', vim.diagnostic.goto_prev, { desc = "[P]revious [D]iagnostic" })
  map('n', '<leader>nd', vim.diagnostic.goto_next, { desc = "[N]ext [D]iagnostic" })
  map('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open Floating Diagnostic Message" })
end

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
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
      on_attach()
      require('lspconfig').lua_ls.setup {}
      require('lspconfig').rust_analyzer.setup {}
    end,
  },
  -- Metals & Plenary
  {
    "scalameta/nvim-metals",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    ft = { "scala", "sbt", "java" },
    opts = function()
      local metals_config = require("metals").bare_config()

      metals_config.init_options.statusBarProvider = "off"
      metals_config.on_attach = function(client, bufnr)
        on_attach(client, bufnr)
      end

      return metals_config
    end,
    config = function(self, metals_config)
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = self.ft,
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
    local telescope_extension = require('telescope').extensions

    map("n", "<leader>mc", telescope_extension.metals.commands, { desc = '[M]etals [C]ommands' })

    end
  }
}
