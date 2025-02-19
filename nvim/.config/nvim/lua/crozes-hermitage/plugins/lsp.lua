local map = require('crozes-hermitage.utils').map

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
  },
  config = function()
    require("mason").setup()
    local mason_lspconfig = require('mason-lspconfig')

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
      nmap('<leader>cl', vim.lsp.codelens.run, '[C]ode [Lens] Run')

      nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
      nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

      nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
      nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
      nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, '[W]orkspace [L]ist Folders')

      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
      end, { desc = 'Format current buffer with LSP' })

      vim.lsp.inlay_hint.enable(true)
      nmap('<leader>ih', function()
        local state = vim.lsp.inlay_hint.is_enabled({})
        print("Toggle Inlay Hint from " .. tostring(state) .. " to " .. tostring(not state))

        vim.lsp.inlay_hint.enable(not state)
      end, 'Toggle [I]nlay [H]int')

      -- Snacks Picker
      nmap('gd', function() Snacks.picker.lsp_definitions() end, 'Goto Definition')
      nmap('gD', function() Snacks.picker.lsp_declarations() end, 'Goto Declaration')
      nmap('gr', function() Snacks.picker.lsp_references() end, 'References')
      nmap('gI', function() Snacks.picker.lsp_implementations() end, 'Goto Implementation')
      nmap('<leader>gt', function() Snacks.picker.lsp_type_definitions() end, 'Goto Type Definition')
      nmap('<leader>ds', function() Snacks.picker.lsp_symbols() end, 'Symbols')
      nmap('<leader>ws', function() Snacks.picker.lsp_workspace_symbols() end, 'Workspace Symbols')
    end

    local servers = {
      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
    }

    local capabilities = vim.lsp.protocol.make_client_capabilities()

    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
      automatic_installation = false,
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
  end,

  -- Metals & Plenary
  --[[ {
    'scalameta/nvim-metals',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      -- metals configuration
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })

      local metals_config = require("metals").bare_config()

      metals_config.init_options.statusBarProvider = "off"

      -- TODO: uncomment when tree view will be fixed
      --[[ metals_config.tvp = {
  icons = {
    enable = true,
  }
} ]]
  --
  --     metals_config.settings = {
  --       showImplicitArguments = true,
  --       showImplicitConversionsAndClasses = true,
  --       showInferredType = true
  --       -- serverVersion = "1.1.1-SNAPSHOT"
  --     }
  --
  --     metals_config.capabilities = capabilities
  --
  --     metals_config.on_attach = function(client, bufnr)
  --       On_attach(client, bufnr)
  --
  --       map("v", "K", require("metals").type_of_range)
  --
  --       map("n", "<leader>hs", function()
  --         require("metals").hover_worksheet({ border = "single" })
  --       end, { desc = '[H]over work[S]heet' })
  --
  --       -- TODO: Figure out why the tree view is opened anytime a file is loaded
  --       -- map("n", "<leader>tt", require("metals.tvp").toggle_tree_view, { desc = '[T]oggle [T]ree' })
  --
  --       -- map("n", "<leader>tr", require("metals.tvp").reveal_in_tree { desc = '[T]ree [R]eveal' })
  --
  --       map("n", "<leader>mts", function()
  --         require("metals").toggle_setting("showImplicitArguments")
  --       end, { desc = '[M]etals [T]oggle [S]howImplicitArguments' })
  --
  --       -- A lot of the servers I use won't support document_highlight or code lens,
  --       -- so we just use them in Metals
  --       vim.api.nvim_create_autocmd("CursorHold", {
  --         callback = vim.lsp.buf.document_highlight,
  --         buffer = bufnr,
  --         group = nvim_metals_group,
  --       })
  --       vim.api.nvim_create_autocmd("CursorMoved", {
  --         callback = function()
  --           vim.lsp.buf.clear_references()
  --         end,
  --         buffer = bufnr,
  --         group = nvim_metals_group,
  --       })
  --       vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
  --         callback = vim.lsp.codelens.refresh,
  --         buffer = bufnr,
  --         group = nvim_metals_group,
  --       })
  --
  --       require("metals").setup_dap()
  --     end
  --   end
  -- }, ]]
}
