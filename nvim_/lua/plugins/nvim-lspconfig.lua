return {
  "neovim/nvim-lspconfig",
  dependencies = { "mason.nvim" },

  opts = {
    servers = {
      lua_ls = {},
      gopls = {},
      rust_analyzer = {},
      ts_ls = {},
    }
  },

  config = function(_, opts)
    -- 1. THE NEW "on_attach" STRATEGY
    -- Instead of passing a function to every server, we use a global autocommand.
    vim.api.nvim_create_autocmd('LspAttach', {
      desc = 'LSP actions',
      callback = function(event)
        local bufnr = event.buf
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        -- Enable auto-formatting on save
        if client and client.supports_method('textDocument/formatting') then
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr, async = false })
            end,
          })
        end

        -- Helper for keymaps
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = bufnr, noremap = true, silent = true, desc = 'LSP: ' .. desc })
        end

        -- Your Keymaps
        map('gd', vim.lsp.buf.definition, 'Go to Definition')
        map('gD', vim.lsp.buf.declaration, 'Go to Declaration')
        map('K', vim.lsp.buf.hover, 'Hover Documentation')
        map('gi', vim.lsp.buf.implementation, 'Go to Implementation')
        map('<leader>ln', vim.lsp.buf.rename, 'Rename')
        map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
      end,
    })

    -- 2. SETUP MASON
    require('mason').setup()

    -- 3. THE NEW "setup" STRATEGY
    -- We loop through servers, register their config, and enable them.
    for server_name, server_opts in pairs(opts.servers) do
      -- Merge default capabilities (e.g., from cmp/blink) if needed
      -- server_opts.capabilities = vim.tbl_deep_extend('force',
      --   vim.lsp.protocol.make_client_capabilities(),
      --   server_opts.capabilities or {}
      -- )

      -- Register the configuration for this server
      -- (This replaces passing opts to the .setup() function)
      if vim.lsp.config[server_name] then
        -- If using Nvim 0.11, this allows extending existing configs
        vim.lsp.config[server_name] = vim.tbl_deep_extend("force", vim.lsp.config[server_name], server_opts)
      else
        vim.lsp.config[server_name] = server_opts
      end

      -- Start the server
      vim.lsp.enable(server_name)
    end
  end
}
