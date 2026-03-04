return {
  -- {
  --  dir = "/Users/stefan.heller/Work/repos/oktaai.nvim",
  -- dev = true,
  -- dependencies = { "nvim-lua/plenary.nvim", "github/copilot.vim" },
  -- config = function()
  --   require("oktaai").setup()
  -- end,  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    opts = {
      ensure_installed = { "lua", "python", "javascript", "typescript", "html", "css", "json", "markdown" },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-u>"] = false,
            ["<C-d>"] = false,
          },
        },
        file_ignore_patterns = {
          "node_modules",
          "vendor",
          "dist"
        },
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  { "folke/which-key.nvim", lazy = true },
  { "nvim-lua/plenary.nvim" },
  {
    "nvim-neorg/neorg",
    ft = "norg",
    opts = {
      load = {
        ["core.defaults"] = {},
      },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    init = function()
      vim.g.startuptime_tries = 10
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
      },
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      luasnip.config.setup({})
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(),        -- Previous item
          ["<C-j>"] = cmp.mapping.select_next_item(),        -- Next item
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),           -- Scroll docs up
          ["<C-f>"] = cmp.mapping.scroll_docs(4),            -- Scroll docs down
          ["<C-Space>"] = cmp.mapping.complete(),            -- Trigger completion
          ["<C-e>"] = cmp.mapping.abort(),                   -- Close completion
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
        }),
        sources = cmp.config.sources({
          { name = "luasnip" }, -- Source for snippets
          { name = "copilot" }, -- Source for snippets
          { name = "buffer" },  -- Source for text in current buffer
          { name = "path" },    -- Source for file system paths
        }),
      })
    end,
  },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "stevearc/dressing.nvim",      event = "VeryLazy" },
  { "catppuccin/nvim",             name = "catppuccin", priority = 1000 },
  {
    "Wansmer/treesj",
    keys = {
      { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },
  {
    "monaqa/dial.nvim",
    keys = { "<C-a>", { "<C-x>", mode = "n" } },
  },
  { "folke/zen-mode.nvim" },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
  },
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = {
      enabled = true, -- if you want to enable the plugin
      message_template = " <author> • <date> • <summary> • <<sha>>", -- template for the blame message, check the Message template section for more options
      date_format = "%m-%d-%Y %H:%M:%S", -- template for the date, check Date format section for more options
      virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
    },

  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },
  { 'mbbill/undotree' },
  { 'tpope/vim-fugitive' },
  { "nvim-treesitter/nvim-treesitter-context" },
}
