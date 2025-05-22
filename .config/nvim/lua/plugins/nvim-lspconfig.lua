return {
  "neovim/nvim-lspconfig",
  dependencies = {"mason.nvim"},

  opts = {
    servers = {
      lua_ls = {},
      gopls = {},
      rust_analyzer = {},
      ts_ls = {},
    }
  },

  config = function(_, opts)
    local lspconfig = require('lspconfig')
    local mason = require('mason')
    mason.setup()

    for server, config in pairs(opts.servers) do
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      lspconfig[server].setup(config)
    end

    -- enable auto formatting
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        if not client then return end

        -- Auto-format ("lint") on save.
        if client:supports_method('textDocument/formatting') then
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = args.buf,
            callback = function()
              vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
            end,
          })
        end
      end,
    })
  end
}
